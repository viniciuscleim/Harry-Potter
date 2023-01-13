//
//  ProfileViewController.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 12/01/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileView: ProfileView?
    var editButton: Bool = true
    
    override func loadView() {
        profileView = ProfileView()
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        profileView?.setDelegate(delegate: self)
    }
    
    private func updateEditButton() {
        if editButton {
            profileView?.editButton.setTitle("Save", for: .normal)
            profileView?.nameTextField.isUserInteractionEnabled = true
            profileView?.emailTextField.isUserInteractionEnabled = true
            profileView?.favoriteCharacterTextField.isUserInteractionEnabled = true
            editButton = false
        } else {
            profileView?.editButton.setTitle("Edit", for: .normal)
            profileView?.nameTextField.isUserInteractionEnabled = false
            profileView?.emailTextField.isUserInteractionEnabled = false
            profileView?.favoriteCharacterTextField.isUserInteractionEnabled = false
            editButton = true
        }
    }
}

//MARK: - ProfileViewDelegate

extension ProfileViewController: ProfileViewDelegate {
    func actionEditUserPictureButton() {
        //implementar imagepicker
    }
    
    func actionEditButton() {
        updateEditButton()
    }
    
    func actionLogoutButton() {
        // alert confirmar sair
    }
    
    func actionDeleteAccountButton() {
        // alert confirmar deletar
    }
}
