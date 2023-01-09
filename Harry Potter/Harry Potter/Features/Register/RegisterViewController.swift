//
//  RegisterViewController.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 21/11/22.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerView: RegisterView?
    
    override func loadView() {
        registerView = RegisterView()
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        }
    

}
