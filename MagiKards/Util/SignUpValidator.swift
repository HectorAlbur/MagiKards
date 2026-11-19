//
//  SignUpValidator.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 19/11/26.
//

import Foundation

protocol SignUpValidatorProtocol {
    func validateName(_ name: String) -> ValidationError?
    func validateEmail(_ email: String) -> ValidationError?
    func validatePassword(_ password: String) -> ValidationError?
    func validatePasswordConfirmation(_ password: String, _ confirmation: String) -> ValidationError?
}

//Reutiliza las reglas del LoginValidator para correo y contraseña
//y agrega las del nombre de entrenador y la confirmación de contraseña
struct SignUpValidator: SignUpValidatorProtocol {
    private let loginValidator: LoginValidatorProtocol
    private let minNameLength: Int = 3

    init(loginValidator: LoginValidatorProtocol = LoginValidator()) {
        self.loginValidator = loginValidator
    }

    func validateName(_ name: String) -> ValidationError? {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return .empty }
        guard trimmed.count >= minNameLength else {
            return .tooShort(min: minNameLength)
        }
        return nil
    }

    func validateEmail(_ email: String) -> ValidationError? {
        loginValidator.validateEmail(email)
    }

    func validatePassword(_ password: String) -> ValidationError? {
        loginValidator.validatePassword(password)
    }

    func validatePasswordConfirmation(_ password: String, _ confirmation: String) -> ValidationError? {
        guard !confirmation.isEmpty else { return .empty }
        return password == confirmation ? nil : .passwordMismatch
    }
}
