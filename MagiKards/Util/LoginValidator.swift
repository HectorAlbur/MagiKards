//
//  LoginValidator.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 20/10/26.
//

import Foundation

enum ValidationError: Equatable{
    case empty
    case invalidFormat
    case tooShort(min: Int )
    
    var message: String {
        switch self {
        case .empty:
            return "Campo vacio"
        case .invalidFormat:
            return "Formato invalido"
        case .tooShort(min: let min):
            return "Debe tener al menos \(min) caracteres"
        }
    }
}

protocol LoginValidatorProtocol {
    func validateEmail(_ email: String)  -> ValidationError?
    func validatePassword(_ password: String) -> ValidationError?
}

struct LoginValidator: LoginValidatorProtocol {
    private let minPasswordLength: Int = 8
    
    func validateEmail(_ email: String) -> ValidationError? {
        let trimmed = email.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {return .empty}
        
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let isValid = trimmed.ranges(of: pattern, options: .regularExpression) != nil
        return isValid ? nil : .invalidFormat
    }
    
    func validatePassword(_ password: String) -> ValidationError? {
        let trimmed = password.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {return .empty}
        guard trimmed.count >= minPasswordLength else {return .tooShort(min: minPasswordLength)}
        return nil
    }
}
