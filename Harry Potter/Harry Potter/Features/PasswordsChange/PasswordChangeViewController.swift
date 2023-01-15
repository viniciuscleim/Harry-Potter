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
    var alert: Alert?
    
    override func loadView() {
        passwordChangeView = PasswordChangeView()
        view = passwordChangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordChangeView?.setDelegate(delegate: self)
        auth = Auth.auth()
        alert = Alert(controller: self)
    }
    
    private func resetPassword() {
        let email = passwordChangeView?.emailTextField.text ?? ""
        
        auth?.sendPasswordReset(withEmail: email, completion: { error in
            if error == nil {
                self.alert?.configAlert(title: "Email enviado com sucesso", message: "Verifique sua caixa de entrada/spam em alguns instantes!")
            } else {
                self.alert?.configAlert(title: "Ops", message: "Algo deu errado, tente novamente!")
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


