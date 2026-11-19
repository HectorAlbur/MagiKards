//
//  LoginValidator.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 20/10/26.
//

import Foundation

enum ValidationError: Equatable {
    case empty
    case invalidFormat
    case tooShort (min: Int)
    case passwordMismatch
    
    var message: String {
        switch self {
        case .empty:
            return "Este campo es obligatorio"
        case .invalidFormat:
            return "El formato no es válido"
        case .tooShort(min: let min):
            return "Debe tener al menos \(min) caracteres"
        case .passwordMismatch:
            return "Las contraseñas no coinciden"
        }
    }
    
}

protocol LoginValidatorProtocol {
    func validateEmail(_ email: String) -> ValidationError?
    func validatePassword(_ password: String) -> ValidationError?
}

struct LoginValidator: LoginValidatorProtocol {
    private let minPasswordLength: Int = 8
    
    func validateEmail(_ email: String) -> ValidationError? {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return .empty
        }
        
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let isValid = trimmed.range(of: pattern, options: .regularExpression) != nil
        return isValid ? nil : .invalidFormat
    }
    
    func validatePassword(_ password: String) -> ValidationError? {
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedPassword.isEmpty else {
            return .empty
        }
        
        guard trimmedPassword.count >= minPasswordLength else {
            return .tooShort(min: minPasswordLength)
        }
        
        return nil
    }
}
