//
//  LoginPresenter.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 13/10/26.
//

import Foundation

protocol LoginView: AnyObject {
    //Todo lo que quiera que haga el login debe ir aquí o no podrá hacerlo
    func showEmailError(message: String?)
    func showPasswordError(message: String?)
    func setLoginButtonEnabled(_ isEnabled: Bool)
    func manageLoader(isLoading: Bool)
    func showLoginError(message: String)
}

final class LoginPresenter {
    weak var view: LoginView?//weak significa que la variable es una referencia débil, o sea, la memoria asignada a esa variable puede ser eliminada cuando se considere necesario
    private let onLoginSuccess: (User) -> Void
    private let onShowSignUp: () -> Void
    private let validator: LoginValidatorProtocol
    private let authRepository: AuthRepositoryProtocol

    init(onLoginSuccess: @escaping (User) -> Void,
         onShowSignUp: @escaping () -> Void,
         validator: LoginValidatorProtocol,
         authRepository: AuthRepositoryProtocol) {
        self.onLoginSuccess = onLoginSuccess
        self.onShowSignUp = onShowSignUp
        self.validator = validator
        self.authRepository = authRepository
    }

    func emailDidEndEditing(_ email: String) {
        view?.showEmailError(message: validator.validateEmail(email)?.message)
    }

    func passwordDidEndEditing(_ password: String) {
        view?.showPasswordError(message: validator.validatePassword(password)?.message)
    }

    func fieldsDidChange(email: String, password: String) {
        let isFormValid = validator.validateEmail(email) == nil && validator.validatePassword(password) == nil
        view?.setLoginButtonEnabled(isFormValid)
    }

    func requestLogin(email: String, password: String) {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        view?.manageLoader(isLoading: true)
        //Op asíncrona
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                let user = try await self.authRepository.signIn(email: email, password: password)
                self.view?.manageLoader(isLoading: false)
                self.onLoginSuccess(user)
            } catch {
                self.view?.manageLoader(isLoading: false)
                self.view?.showLoginError(message: error.localizedDescription)
            }
        }
    }

    func showSignUp() {
        onShowSignUp()
    }
}
