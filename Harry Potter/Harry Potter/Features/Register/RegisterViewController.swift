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
    
    override func loadView() {
        registerView = RegisterView()
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerView?.setDelegate(delegate: self)
        auth = Auth.auth()
    }
    
    private func makeRegister() {
        let email = registerView?.emailTextField.text ?? ""
        let password = registerView?.passwordTextField.text ?? ""
        
        auth?.createUser(withEmail: email, password: password, completion: { user, error in
            if error != nil {
                //alert erro
            } else {
                //alert sucesso
                let vc: TabBarController = TabBarController()
                vc.selectedIndex = 2
                vc.isNewUser = user?.additionalUserInfo?.isNewUser
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
}

//MARK: - PasswordViewDelegate

extension RegisterViewController: RegisterViewDelegate {
    func actionReturnButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func actionRegisterButton() {
        makeRegister()
    }
}
