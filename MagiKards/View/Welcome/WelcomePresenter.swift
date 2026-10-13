//
//  WelcomePresenter.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 13/10/26.
//

import Foundation

final class WelcomePresenter {
    private let onShowLogin: () -> Void
    
    init(onShowLogin: @escaping () -> Void) {
        self.onShowLogin = onShowLogin
    }
    
    func showLogin() {
        onShowLogin()
    }
}
