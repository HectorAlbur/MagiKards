//
//  SignUpPresenter.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 15/10/26.
//

import Foundation

protocol SignUpView: AnyObject {
    func showNameError(message: String?)
    func showEmailError(message: String?)
    func showPasswordError(message: String?)
    func showConfirmPasswordError(message: String?)
    func setSignUpButtonEnabled(_ isEnabled: Bool)
    func manageLoader(isLoading: Bool)
    func showSignUpError(message: String)
}

final class SignUpPresenter {
    weak var view: SignUpView?

    private let onSignUpSuccess: (User) -> Void
    private let onShowLogin: () -> Void
    private let validator: SignUpValidatorProtocol
    private let authRepository: AuthRepositoryProtocol

    init(onSignUpSuccess: @escaping (User) -> Void,
         onShowLogin: @escaping () -> Void,
         validator: SignUpValidatorProtocol,
         authRepository: AuthRepositoryProtocol) {
        self.onSignUpSuccess = onSignUpSuccess
        self.onShowLogin = onShowLogin
        self.validator = validator
        self.authRepository = authRepository
    }

    func nameDidEndEditing(_ name: String) {
        view?.showNameError(message: validator.validateName(name)?.message)
    }

    func emailDidEndEditing(_ email: String) {
        view?.showEmailError(message: validator.validateEmail(email)?.message)
    }

    func passwordDidEndEditing(_ password: String) {
        view?.showPasswordError(message: validator.validatePassword(password)?.message)
    }

    func confirmPasswordDidEndEditing(password: String, confirmation: String) {
        view?.showConfirmPasswordError(message: validator.validatePasswordConfirmation(password, confirmation)?.message)
    }

    func fieldsDidChange(name: String, email: String, password: String, confirmation: String) {
        let isFormValid = validator.validateName(name) == nil &&
                          validator.validateEmail(email) == nil &&
                          validator.validatePassword(password) == nil &&
                          validator.validatePasswordConfirmation(password, confirmation) == nil
        view?.setSignUpButtonEnabled(isFormValid)
    }

    func requestSignUp(name: String, email: String, password: String) {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        view?.manageLoader(isLoading: true)
        //Op asíncrona: crea la cuenta en Firebase
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                let user = try await self.authRepository.signUp(name: name, email: email, password: password)
                self.view?.manageLoader(isLoading: false)
                self.onSignUpSuccess(user)
            } catch {
                self.view?.manageLoader(isLoading: false)
                self.view?.showSignUpError(message: error.localizedDescription)
            }
        }
    }

    func showLogin() {
        onShowLogin()
    }
}
