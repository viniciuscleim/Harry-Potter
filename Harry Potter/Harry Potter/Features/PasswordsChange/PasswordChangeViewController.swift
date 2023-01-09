//
//  PasswordChangeViewController.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 16/11/22.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    
    var passwordChangeView: PasswordChangeView?
    
    override func loadView() {
        passwordChangeView = PasswordChangeView()
        view = passwordChangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordChangeView?.setDelegate(delegate: self)
        
    }
    
    
    
}

//MARK: - passwordViewDelegate

extension PasswordChangeViewController: PasswordViewDelegate {
    func actionReturnButton() {
        navigationController?.popViewController(animated: true)
        
    }
    
}


