//
//  HomePresenter.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 19/11/26.
//

import Foundation

protocol HomeView: AnyObject {
    func showGreeting(name: String, email: String)
    func showError(message: String)
}

final class HomePresenter {
    weak var view: HomeView?

    private let user: User
    private let authRepository: AuthRepositoryProtocol
    private let onSignOut: () -> Void

    init(user: User,
         authRepository: AuthRepositoryProtocol,
         onSignOut: @escaping () -> Void) {
        self.user = user
        self.authRepository = authRepository
        self.onSignOut = onSignOut
    }

    func viewDidLoad() {
        view?.showGreeting(name: user.name, email: user.email)
    }

    func signOut() {
        do {
            try authRepository.signOut()
            onSignOut()
        } catch {
            view?.showError(message: error.localizedDescription)
        }
    }
}
