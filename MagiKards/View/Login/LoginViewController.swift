//
//  LoginViewController.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 29/09/26.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!

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
        setupView()
    }

    func setupView() {
        emailTextField.delegate = self
        passwordTextField.delegate = self

        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

        //El botón inicia deshabilitado hasta que el formulario sea válido
        setLoginButtonEnabled(false)
    }

    @objc private func textDidChange() {
        presenter.fieldsDidChange(email: emailTextField.text ?? "",
                                  password: passwordTextField.text ?? "")
    }

    @IBAction func requestLogin(_ sender: UIButton) {
        view.endEditing(true)
        presenter.requestLogin(email: emailTextField.text ?? "",
                               password: passwordTextField.text ?? "")
    }

    @IBAction func showSignUp(_ sender: UIButton) {
        presenter.showSignUp()
    }
}

extension LoginViewController: LoginView {
    func showEmailError(message: String?) {
        emailErrorLabel.text = message
        emailErrorLabel.isHidden = message == nil
    }

    func showPasswordError(message: String?) {
        passwordErrorLabel.text = message
        passwordErrorLabel.isHidden = message == nil
    }

    func setLoginButtonEnabled(_ isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
        loginButton.alpha = isEnabled ? 1 : 0.5
    }

    func manageLoader(isLoading: Bool) {
        isLoading ? showLoader() : hideLoader()
    }

    func showLoginError(message: String) {
        showAlert(title: "No pudimos iniciar sesión", message: message)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            presenter.emailDidEndEditing(textField.text ?? "")
        } else {
            presenter.passwordDidEndEditing(textField.text ?? "")
        }
    }

    //Al presionar "return" pasa al siguiente campo o cierra el teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
