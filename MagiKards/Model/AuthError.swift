//
//  AuthError.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 03/11/26.
//

import Foundation

//Errores de autenticación propios de la app (independientes de Firebase)
enum AuthError: LocalizedError {
    case invalidCredentials
    case emailAlreadyInUse
    case weakPassword
    case network
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Correo o contraseña incorrectos"
        case .emailAlreadyInUse:
            return "Este correo ya está registrado"
        case .weakPassword:
            return "La contraseña es muy débil"
        case .network:
            return "Error de conexión, revisa tu internet"
        case .unknown:
            return "Ocurrió un error, intenta de nuevo"
        }
    }
}
