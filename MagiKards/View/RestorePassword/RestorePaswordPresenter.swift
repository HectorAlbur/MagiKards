//
//  RestorePaswordPresenter.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 15/10/26.
//

import Foundation

protocol RestorePasswordView: AnyObject {
    
}

final class RestorePasswordPresenter {
    weak var view : RestorePasswordView?
    
    private let onRestorePasswordSuccess : () -> Void
    
    init(onRestorePasswordSuccess: @escaping () -> Void) {
        self.onRestorePasswordSuccess = onRestorePasswordSuccess
    }
    
}
