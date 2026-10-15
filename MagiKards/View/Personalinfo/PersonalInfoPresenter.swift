//
//  PersonalInfoPresenter.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 15/10/26.
//

import Foundation

protocol PersonalInfoView: AnyObject {
    //La lógica va aquí
}

final class PersonalInfoPresenter {
    weak var view: PersonalInfoView?
    
    private let onSaveSuccess: () -> Void
    
    init(onSaveSuccess: @escaping () -> Void) {
        self.onSaveSuccess = onSaveSuccess
    }
}


