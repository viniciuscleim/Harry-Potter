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
        auth = Auth.auth()
        view.backgroundColor = UIColor(red: 255/255, green: 170/255, blue: 52/255, alpha: 1.0)
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
}

//MARK: - loginViewDelegate

extension LoginViewController: LoginViewDelegate {
    func actionForgotPasswordButton() {
        let nextViewController: PasswordChangeViewController = PasswordChangeViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func actionSignInButton() {
        validateLogin()
    }
    
    func actionRegisterButton() {
        let nextViewController: RegisterViewController = RegisterViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
