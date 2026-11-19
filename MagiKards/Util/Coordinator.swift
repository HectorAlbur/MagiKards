//
//  Coordinator.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//
import UIKit

//Intancia vistas y las muestra mediante el viewController
final class AppCoordinator {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory

    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    //Instancia la vista welcomeViewController porque es la primera pantalla de la app
    func start() {
        let viewController = factory.makeWelcomeViewController(
            onShowLogin: { [weak self] in
                self?.showLogin()
            },
            onShowSignUp: { [weak self] in
                self?.showSignUp()
            })
        navigationController.setViewControllers([viewController], animated: true)
    }

    private func showLogin() {
        //Si ya venimos de Login (Login → Registro → "Ya tengo una cuenta") regresamos en lugar de apilar otra pantalla
        if let login = navigationController.viewControllers.first(where: { $0 is LoginViewController }) {
            navigationController.popToViewController(login, animated: true)
            return
        }
        let viewController = factory.makeLoginViewController(
            onLoginSuccess: { [weak self] user in
                self?.showHome(user: user)
            },
            onShowSignUp: { [weak self] in
                self?.showSignUp()
            })
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showSignUp() {
        //Mismo caso que en showLogin, pero al revés
        if let signUp = navigationController.viewControllers.first(where: { $0 is SignUpViewController }) {
            navigationController.popToViewController(signUp, animated: true)
            return
        }
        let viewController = factory.makeSignUpViewController(
            onSignUpSuccess: { [weak self] user in
                self?.showHome(user: user)
            },
            onShowLogin: { [weak self] in
                self?.showLogin()
            })
        navigationController.pushViewController(viewController, animated: true)
    }

    //Al iniciar sesión o registrarse se reemplaza toda la pila para que no se pueda regresar al login
    private func showHome(user: User) {
        let viewController = factory.makeHomeViewController(user: user) { [weak self] in
            self?.start()
        }
        navigationController.setViewControllers([viewController], animated: true)
    }

    //Si qusieramos agregar la navegación a otra pantalla, primero debemos definir el
    //método en ViewControllerFactory y aquí definir el método para crear el viewController
    //y movernos a esa pantalla
}

protocol ViewControllerFactory {
    func makeWelcomeViewController(onShowLogin: @escaping () -> Void,
                                   onShowSignUp: @escaping () -> Void) -> UIViewController
    func makeLoginViewController(onLoginSuccess: @escaping (User) -> Void,
                                 onShowSignUp: @escaping () -> Void) -> UIViewController
    func makeSignUpViewController(onSignUpSuccess: @escaping (User) -> Void,
                                  onShowLogin: @escaping () -> Void) -> UIViewController
    func makeHomeViewController(user: User,
                                onSignOut: @escaping () -> Void) -> UIViewController
    func makePersonalInfoViewController(onSaveSuccess: @escaping () -> Void) -> UIViewController

    //Cada que hagamos una pantalla se agrega aquí su método.
    //Si alguna pantalla necesitara una dependencia, la dependencia se pone como
    //parámetro del método respectivo
}

final class AppDIContainer: ViewControllerFactory {
    //Un solo repositorio de autenticación compartido por todas las pantallas
    private lazy var authRepository: AuthRepositoryProtocol = FirebaseAuthRepository()

    func makeWelcomeViewController(onShowLogin: @escaping () -> Void,
                                   onShowSignUp: @escaping () -> Void) -> UIViewController {
        let presenter = WelcomePresenter(onShowLogin: onShowLogin,
                                         onShowSignUp: onShowSignUp)
        return WelcomeViewController(presenter: presenter)
    }

    func makeLoginViewController(onLoginSuccess: @escaping (User) -> Void,
                                 onShowSignUp: @escaping () -> Void) -> UIViewController {
        let presenter = LoginPresenter(onLoginSuccess: onLoginSuccess,
                                       onShowSignUp: onShowSignUp,
                                       validator: LoginValidator(),
                                       authRepository: authRepository)
        let viewController = LoginViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeSignUpViewController(onSignUpSuccess: @escaping (User) -> Void,
                                  onShowLogin: @escaping () -> Void) -> UIViewController {
        let presenter = SignUpPresenter(onSignUpSuccess: onSignUpSuccess,
                                        onShowLogin: onShowLogin,
                                        validator: SignUpValidator(),
                                        authRepository: authRepository)
        let viewController = SignUpViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeHomeViewController(user: User,
                                onSignOut: @escaping () -> Void) -> UIViewController {
        let presenter = HomePresenter(user: user,
                                      authRepository: authRepository,
                                      onSignOut: onSignOut)
        let viewController = HomeViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makePersonalInfoViewController(onSaveSuccess: @escaping () -> Void) -> UIViewController {
        let presenter = PersonalInfoPresenter(onSaveSuccess: onSaveSuccess)
        return PersonalInfoViewController(presenter: presenter)
    }
}
