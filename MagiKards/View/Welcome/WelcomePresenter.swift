//
//  WelcomePresenter.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 13/10/26.
//

import Foundation

final class WelcomePresenter {
    private let onShowLogin: () -> Void
    private let onShowSignUp: () -> Void

    init(onShowLogin: @escaping () -> Void,
         onShowSignUp: @escaping () -> Void) {
        self.onShowLogin = onShowLogin
        self.onShowSignUp = onShowSignUp
    }

    func showLogin() {
        onShowLogin()
    }

    func showSignUp() {
        onShowSignUp()
    }
}
