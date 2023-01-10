//
//  PasswordChangeViewController.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 09/01/23.
//

import UIKit
import FirebaseAuth

class PasswordChangeViewController: UIViewController {
    
    var passwordChangeView: PasswordChangeView?
    var auth: Auth?
    
    override func loadView() {
        passwordChangeView = PasswordChangeView()
        view = passwordChangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordChangeView?.setDelegate(delegate: self)
        auth = Auth.auth()
    }
    
    private func resetPassword() {
        let email = passwordChangeView?.emailTextField.text ?? ""
        
        auth?.sendPasswordReset(withEmail: email, completion: { error in
            if error == nil {
                //alert de sucesso
            } else {
                //alert de erro
            }
        })
    }
}

//MARK: - PasswordViewDelegate

extension PasswordChangeViewController: PasswordViewDelegate {
    func actionReturnButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func actionSendEmailButton() {
        resetPassword()
    }
}


