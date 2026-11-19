//
//  User.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 03/11/26.
//

import Foundation

//Modelo de usuario de la app (dominio)
struct User: Equatable {
    let id: String
    let email: String
    let name: String
}
