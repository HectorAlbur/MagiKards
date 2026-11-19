//
//  AuthRepository.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 03/11/26.
//

import Foundation
import FirebaseAuth

protocol AuthRepositoryProtocol {
    var currentUser: User? { get }
    func signIn(email: String, password: String) async throws -> User
    func signUp(name: String, email: String, password: String) async throws -> User
    func signOut() throws
}

final class FirebaseAuthRepository: AuthRepositoryProtocol {
    private let auth: Auth

    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }

    var currentUser: User? {
        auth.currentUser.map(Self.mapUser)
    }

    //Inicio de sesión con correo y contraseña
    func signIn(email: String, password: String) async throws -> User {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            return Self.mapUser(result.user)
        } catch {
            throw Self.mapError(error)
        }
    }

    //Registro: crea el usuario en Firebase y le guarda el nombre de entrenador
    func signUp(name: String, email: String, password: String) async throws -> User {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)

            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = name
            try? await changeRequest.commitChanges()

            return User(id: result.user.uid, email: email, name: name)
        } catch {
            throw Self.mapError(error)
        }
    }

    func signOut() throws {
        do { try auth.signOut() } catch { throw AuthError.unknown }
    }

    // MARK: - Mapeos Firebase → dominio

    // `FirebaseAuth.User` es el de Firebase; `User` es el nuestro.
    private static func mapUser(_ fbUser: FirebaseAuth.User) -> User {
        let email = fbUser.email ?? ""
        let fallbackName = email.components(separatedBy: "@").first ?? ""
        return User(id: fbUser.uid,
                    email: email,
                    name: fbUser.displayName ?? fallbackName)
    }

    private static func mapError(_ error: Error) -> AuthError {
        guard let code = AuthErrorCode(_bridgedNSError: error as NSError) else {
            return .unknown
        }

        switch code.code {
        case .wrongPassword, .userNotFound, .invalidCredential, .invalidEmail:
            return .invalidCredentials
        case .emailAlreadyInUse:
            return .emailAlreadyInUse
        case .weakPassword:
            return .weakPassword
        case .networkError:
            return .network
        default:
            return .unknown
        }
    }
}
