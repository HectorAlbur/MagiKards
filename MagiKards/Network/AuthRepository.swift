//
//  AuthRepository.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 03/11/26.
//

import Foundation

protocol AuthRepositoryProtocol {
    var currentUser: User? {get}
    func signIn(email: String, password: String) async throws -> User
    func signUp(name: String, email: String, password: String) async throws -> User?
    func signOut() throws
}
