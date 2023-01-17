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
        view.backgroundColor = UIColor(red: 83/255, green: 17/255, blue: 27/255, alpha: 1.0)
        
        passwordChangeView?.setDelegate(delegate: self)
        passwordChangeView?.setupTextFieldDelegate(delegate: self)
        auth = Auth.auth()
        alert = Alert(controller: self)
        passwordChangeView?.sendEmailButton.isEnabled = false
        enableButton()
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

//MARK: - UITextFieldDelegate

extension PasswordChangeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        enableButton()
    }
    
    private func enableButton() {
        if passwordChangeView?.emailTextField.text == "" {
            passwordChangeView?.sendEmailButton.isEnabled = false
            passwordChangeView?.sendEmailButton.setTitleColor(.lightGray, for: .normal)
        } else {
            passwordChangeView?.sendEmailButton.isEnabled = true
            passwordChangeView?.sendEmailButton.setTitleColor(.white, for: .normal)
        }
    }
}
