//
//  RegisterViewController.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 09/01/23.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    var registerView: RegisterView?
    var auth: Auth?
    var alert: Alert?
    var isTextFieldEmpty: Bool = true
    var isPasswordsEqual: Bool = false
    
    override func loadView() {
        registerView = RegisterView()
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerView?.setDelegate(delegate: self)
        registerView?.setupTextFieldDelegate(delegate: self)
        auth = Auth.auth()
        alert = Alert(controller: self)
        enableButton()
    }
    
    private func makeRegister() {
        let email = registerView?.emailTextField.text ?? ""
        let password = registerView?.passwordTextField.text ?? ""
        
        auth?.createUser(withEmail: email, password: password, completion: { user, error in
            if error != nil {
                self.alert?.configAlert(title: "Ops", message: "Algo deu errado, tente novamente!")
            } else {
                let vc: TabBarController = TabBarController()
                vc.selectedIndex = 2
                vc.isNewUser = user?.additionalUserInfo?.isNewUser
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
    
    private func seePasswordButtonLogic(type: PasswordType) {
        switch type {
        case .password:
            if registerView?.seePasswordButton.currentImage == UIImage(systemName: "eye.slash") {
                registerView?.seePasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
                registerView?.passwordTextField.isSecureTextEntry = false
            } else {
                registerView?.seePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                registerView?.passwordTextField.isSecureTextEntry = true
            }
        case .confirmPassword:
            if registerView?.seeConfirmPasswordButton.currentImage == UIImage(systemName: "eye.slash") {
                registerView?.seeConfirmPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
                registerView?.confirmPasswordTextField.isSecureTextEntry = false
            } else {
                registerView?.seeConfirmPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                registerView?.confirmPasswordTextField.isSecureTextEntry = true
            }
        }
    }
}

//MARK: - PasswordViewDelegate

extension RegisterViewController: RegisterViewDelegate {
    
    func actionReturnButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func actionSeePasswordButton() {
        seePasswordButtonLogic(type: .password)
    }
    
    func actionSeeConfirmPasswordButton() {
        seePasswordButtonLogic(type: .confirmPassword)
    }
    
    func actionRegisterButton() {
        makeRegister()
    }
}

//MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(registerView?.emailTextField) {
            registerView?.emailTextField.resignFirstResponder()
            registerView?.passwordTextField.becomeFirstResponder()
        } else if textField.isEqual(registerView?.passwordTextField) {
            registerView?.passwordTextField.resignFirstResponder()
            registerView?.confirmPasswordTextField.becomeFirstResponder()
        } else {
            registerView?.confirmPasswordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        enableButton()
    }
    
    private func enableButton() {
        validateEqualPasswords()
        chackIfThereIsAnEmptyTextField()
        
        if isPasswordsEqual && isTextFieldEmpty == false {
            registerView?.registerButton.isEnabled = true
            registerView?.registerButton.setTitleColor(.white, for: .normal)
        } else {
            registerView?.registerButton.isEnabled = false
            registerView?.registerButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    private func validateEqualPasswords() {
        if registerView?.passwordTextField.text == registerView?.confirmPasswordTextField.text {
            isPasswordsEqual = true
            registerView?.wrongPasswordLabel.isHidden = true
        } else {
            isPasswordsEqual = false
            registerView?.wrongPasswordLabel.isHidden = false
        }
    }
    
    private func chackIfThereIsAnEmptyTextField() {
        if registerView?.emailTextField.text == "" || registerView?.passwordTextField.text == "" || registerView?.confirmPasswordTextField.text == "" {
            isTextFieldEmpty = true
        } else {
            isTextFieldEmpty = false
        }
    }
}
