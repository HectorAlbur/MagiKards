//
//  LoginPresenter.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 13/10/26.
//

import Foundation

protocol LoginView: AnyObject{
    //Todo lo que quiera que haga el login debe ir aquí o no podrá hacerlo
    func showEmailError(message: String?)
    func showPasswordError(message: String?)
    func setLoginButtonEnable(_ isEnable: Bool)
}

final class LoginPresenter {
    weak var view: LoginView?//weak significa que la variable es una referencia débil, o sea, la memoria asignada a esa variable puede ser eliminada cuando se considere necesario
    private let onLoginSuccess: () -> Void
    private let validator: LoginValidatorProtocol
    
    init(onLoginSuccess: @escaping () -> Void,
         validator: LoginValidatorProtocol) {
        self.onLoginSuccess = onLoginSuccess
        self.validator = validator
    }
    
    func emailDidEndEditing(_ email: String) {
        view?.showEmailError(message: validator.validateEmail(email)?.message)
    }
    
    func passwordDidEndEditing(_ password: String) {
        view?.showPasswordError(message: validator.validatePassword(password)?.message)
    }
    
    func fieldDidChange(email: String, password: String) {
        let isFormValid = validator.validateEmail(email) == nil && validator.validatePassword(password) == nil
        view?.setLoginButtonEnable(isFormValid)
    }
}
