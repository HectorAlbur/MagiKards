//
//  LoginViewController.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 29/09/26.
//

import UIKit

class LoginViewController: UIViewController {
    private let presenter: LoginPresenter
    
    init(presenter: LoginPresenter) {
        self.presenter = presenter
        super.init(nibName: "LoginViewController", bundle: nil)//el nibName es el nombre del XIB
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
