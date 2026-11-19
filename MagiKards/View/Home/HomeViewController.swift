//
//  HomeViewController.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 19/11/26.
//

import UIKit

//Pantalla temporal que se muestra al iniciar sesión o registrarse.
//La vista se arma por código (no tiene XIB) porque solo confirma que la sesión funciona.
class HomeViewController: UIViewController {
    private let presenter: HomePresenter

    private let titleLabel = UILabel()
    private let emailLabel = UILabel()
    private let signOutButton = UIButton(type: .system)

    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "marketCanvas") ?? .systemBackground

        let brandLabel = UILabel()
        brandLabel.text = "M A G I K A R D S   /   MARKET"
        brandLabel.font = UIFont(name: "AvenirNext-Bold", size: 11)
        brandLabel.textColor = UIColor(named: "marketAccent")

        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 34)
        titleLabel.textColor = UIColor(named: "marketText")
        titleLabel.numberOfLines = 0

        emailLabel.font = UIFont(name: "AvenirNext-Regular", size: 15)
        emailLabel.textColor = UIColor(named: "marketMuted")
        emailLabel.numberOfLines = 0

        signOutButton.setTitle("Cerrar sesión", for: .normal)
        signOutButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.backgroundColor = UIColor(named: "marketAccent")
        signOutButton.layer.cornerRadius = 16
        signOutButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [brandLabel, titleLabel, emailLabel, signOutButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.setCustomSpacing(32, after: emailLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    @objc private func signOutTapped() {
        presenter.signOut()
    }
}

extension HomeViewController: HomeView {
    func showGreeting(name: String, email: String) {
        titleLabel.text = "¡Hola, \(name)!"
        emailLabel.text = "Sesión iniciada como \(email)"
    }

    func showError(message: String) {
        showAlert(title: "Error", message: message)
    }
}
