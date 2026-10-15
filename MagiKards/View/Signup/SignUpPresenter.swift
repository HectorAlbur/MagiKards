//
//  SignUpPresenter.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 15/10/26.
//

import Foundation

protocol SignUpView: AnyObject {
    
}

final class SignUpPresenter {
    weak var view: SignUpView?
    
    private let onSignUpSuccess: () -> Void
    
    init(onSignUpSuccess: @escaping () -> Void) {
        self.onSignUpSuccess = onSignUpSuccess
    }
}
