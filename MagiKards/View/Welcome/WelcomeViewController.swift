//
//  WelcomeViewController.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import UIKit

class WelcomeViewController: UIViewController {
    private let presenter: WelcomePresenter

    init(presenter: WelcomePresenter) {
        self.presenter = presenter
        super.init(nibName: "WelcomeViewController", bundle: nil)//el nibName es el nombre del XIB
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showLogin(_ sender: UIButton) {
        presenter.showLogin()
    }

    @IBAction func showSignUp(_ sender: UIButton) {
        presenter.showSignUp()
    }
}
