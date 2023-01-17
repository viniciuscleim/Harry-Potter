//
//  LoginViewController.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 09/01/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let user = Auth.auth().currentUser
    let fireStore = Firestore.firestore()
    
    var loginView: LoginView?
    var auth: Auth?
    var alert: Alert?
    
    override func loadView() {
        loginView = LoginView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView?.setDelegate(delegate: self)
        loginView?.setupTextFieldDelegate(delegate: self)
        enableButton()

        view.backgroundColor = UIColor(red: 83/255, green: 17/255, blue: 27/255, alpha: 1.0)
        
        auth = Auth.auth()
        alert = Alert(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func validateLogin() {
        let email = loginView?.emailTextField.text ?? ""
        let password = loginView?.passwordTexField.text ?? ""
        
        auth?.signIn(withEmail: email, password: password, completion: { user, error in
            if error != nil {
                self.alert?.configAlert(title: "Ops", message: "Algo deu errado, tente novamente!")
            } else {
                if user == nil {
                    self.alert?.configAlert(title: "Ops", message: "Usuário não encontrado")
                } else {
                    self.makeLogin()
                }
            }
        })
    }
    
    private func makeLogin() {
        let vc: TabBarController = TabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func seePasswordButtonLogic() {
        if loginView?.seePasswordButton.currentImage == UIImage(systemName: "eye.slash") {
            loginView?.seePasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
            loginView?.passwordTexField.isSecureTextEntry = false
        } else {
            loginView?.seePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            loginView?.passwordTexField.isSecureTextEntry = true
        }
    }
}

//MARK: - loginViewDelegate

extension LoginViewController: LoginViewDelegate {
    
    func actionForgotPasswordButton() {
        let nextViewController: PasswordChangeViewController = PasswordChangeViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func actionSeePasswordButton() {
        seePasswordButtonLogic()
    }
    
    func actionSignInButton() {
        validateLogin()
    }
    
    func actionRegisterButton() {
        let nextViewController: RegisterViewController = RegisterViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(loginView?.emailTextField) {
            loginView?.emailTextField.resignFirstResponder()
            loginView?.passwordTexField.becomeFirstResponder()
        } else {
            loginView?.passwordTexField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        enableButton()
    }
    
    private func enableButton() {
        if loginView?.emailTextField.text == "" || loginView?.passwordTexField.text == "" {
            loginView?.signInButton.isEnabled = false
            loginView?.signInButton.setTitleColor(.lightGray, for: .normal)
        } else {
            loginView?.signInButton.isEnabled = true
            loginView?.signInButton.setTitleColor(.white, for: .normal)
        }
    }
}
