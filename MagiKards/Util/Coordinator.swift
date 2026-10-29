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
    func start(){
        let viewController = factory.makeWelcomeViewController{ [weak self] in
            self?.showLogin()
        }
        navigationController.viewControllers = [viewController]
    }
    
    private func showLogin() {
        let viewController = factory.makeLoginViewController{
            [weak self] in
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //Si qusieramos agregar la navegación a otra pantalla, primero debemos definir el
    //método en ViewControllerFactory y aquí definir el método para crear el viewController
    //y movernos a esa pantalla
    
}

protocol ViewControllerFactory {
    func makeWelcomeViewController(onShowLogin: @escaping () -> Void) -> UIViewController
    func makeLoginViewController(onLoginSuccess: @escaping () -> Void) -> UIViewController
    func makePersonalInfoViewController(onSaveSuccess: @escaping () -> Void) -> UIViewController
    
    //Aquí irían:
    //function makeLoginViewController
    //function makeOtrasPantallasViewController
    //etc...
    //Cada que hagamos una pantalla
    //Si alguna pantalla necesitara una dependencia, la dependencia se pone como
    //parámetro del método respectivo
}

final class AppDIContainer: ViewControllerFactory {
    func makeWelcomeViewController(onShowLogin: @escaping () -> Void) -> UIViewController {
        let presenter = WelcomePresenter(onShowLogin: onShowLogin)
        return WelcomeViewController(presenter: presenter)
    }
    
    func makeLoginViewController(onLoginSuccess: @escaping () -> Void) -> UIViewController {
        let presenter = LoginPresenter(onLoginSuccess: onLoginSuccess, validator: LoginValidator())
        let viewController = LoginViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
    
    func makePersonalInfoViewController(onSaveSuccess: @escaping () -> Void) -> UIViewController {
        let presenter = PersonalInfoPresenter(onSaveSuccess: onSaveSuccess)
        return PersonalInfoViewController(presenter: presenter)
    }
    
    
}
