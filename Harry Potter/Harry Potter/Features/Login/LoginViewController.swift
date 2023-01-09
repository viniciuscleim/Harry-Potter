//
//  LoginViewController.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 16/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginView: LoginView?
    
    override func loadView() {
        loginView = LoginView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView?.setDelegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
}

//MARK: - loginViewDelegate

extension LoginViewController: LoginViewDelegate {
    func actionForgotPasswordButton() {
        let nextViewController: PasswordChangeViewController = PasswordChangeViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    func actionSignInButton() {
        
    }
    
    func actionRegisterButton() {
        let nextViewController: RegisterViewController = RegisterViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    
}
