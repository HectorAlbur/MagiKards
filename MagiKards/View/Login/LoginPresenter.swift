//
//  LoginPresenter.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 13/10/26.
//

import Foundation

protocol LoginView: AnyObject{
    //Todo lo que quiera que haga el login debe ir aquí o no podrá hacerlo
}

final class LoginPresenter {
    weak var view: LoginView?//weak significa que la variable es una referencia débil, o sea, la memoria asignada a esa variable puede ser eliminada cuando se considere necesario
    private let onLoginSuccess: () -> Void
    
    init(onLoginSuccess: @escaping () -> Void) {
        self.onLoginSuccess = onLoginSuccess
    }
}
