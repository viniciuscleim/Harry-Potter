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
    
    var loginView: LoginView?
    let user = Auth.auth().currentUser
    let fireStore = Firestore.firestore()
    var auth: Auth?
    
    override func loadView() {
        loginView = LoginView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView?.setDelegate(delegate: self)
        auth = Auth.auth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func validateLogin() {
        let email = loginView?.emailTextField.text ?? ""
        let password = loginView?.passwordTexField.text ?? ""
        
        auth?.signIn(withEmail: email, password: password, completion: { user, error in
            if error != nil {
                //alert de erro
                print("ERROR")
            } else {
                if user == nil {
                    //alert usuário não encontrado
                    print("ERROR NÃO ENCONTRADO")
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
