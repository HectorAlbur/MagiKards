//
//  SignUpViewController.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 29/09/26.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!

    private let presenter: SignUpPresenter

    init(presenter: SignUpPresenter) {
        self.presenter = presenter
        super.init(nibName: "SignUpViewController", bundle: nil)//el nibName es el nombre del XIB
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        let textFields: [UITextField] = [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField]
        textFields.forEach { textField in
            textField.delegate = self
            textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        }

        //El botón inicia deshabilitado hasta que el formulario sea válido
        setSignUpButtonEnabled(false)
    }

    @objc private func textDidChange() {
        presenter.fieldsDidChange(name: nameTextField.text ?? "",
                                  email: emailTextField.text ?? "",
                                  password: passwordTextField.text ?? "",
                                  confirmation: confirmPasswordTextField.text ?? "")
    }

    @IBAction func requestSignUp(_ sender: UIButton) {
        view.endEditing(true)
        presenter.requestSignUp(name: nameTextField.text ?? "",
                                email: emailTextField.text ?? "",
                                password: passwordTextField.text ?? "")
    }

    @IBAction func showLogin(_ sender: UIButton) {
        presenter.showLogin()
    }
}

extension SignUpViewController: SignUpView {
    func showNameError(message: String?) {
        nameErrorLabel.text = message
        nameErrorLabel.isHidden = message == nil
    }

    func showEmailError(message: String?) {
        emailErrorLabel.text = message
        emailErrorLabel.isHidden = message == nil
    }

    func showPasswordError(message: String?) {
        passwordErrorLabel.text = message
        passwordErrorLabel.isHidden = message == nil
    }

    func showConfirmPasswordError(message: String?) {
        confirmPasswordErrorLabel.text = message
        confirmPasswordErrorLabel.isHidden = message == nil
    }

    func setSignUpButtonEnabled(_ isEnabled: Bool) {
        signUpButton.isEnabled = isEnabled
        signUpButton.alpha = isEnabled ? 1 : 0.5
    }

    func manageLoader(isLoading: Bool) {
        isLoading ? showLoader() : hideLoader()
    }

    func showSignUpError(message: String) {
        showAlert(title: "No pudimos crear tu cuenta", message: message)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            presenter.nameDidEndEditing(textField.text ?? "")
        case emailTextField:
            presenter.emailDidEndEditing(textField.text ?? "")
        case passwordTextField:
            presenter.passwordDidEndEditing(textField.text ?? "")
        default:
            presenter.confirmPasswordDidEndEditing(password: passwordTextField.text ?? "",
                                                   confirmation: textField.text ?? "")
        }
    }

    //Al presionar "return" pasa al siguiente campo o cierra el teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
