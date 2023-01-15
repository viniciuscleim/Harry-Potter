//
//  ProfileViewController.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 12/01/23.
//

import UIKit
import FirebaseAuth
import AlamofireImage

class ProfileViewController: UIViewController {
    
    var profileView: ProfileView?
    var editButton: Bool = true
    
    let viewModel: ProfileViewModel = ProfileViewModel()
    let currentUser = Auth.auth().currentUser
    let pickerController: UIImagePickerController = UIImagePickerController()
    
    override func loadView() {
        profileView = ProfileView()
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        profileView?.setDelegate(delegate: self)
        pickerController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getUserDataFromFirebase(nameTF: profileView?.nameTextField ?? UITextField(),
                                          emailTF: profileView?.emailTextField ?? UITextField(),
                                          favoriteTF: profileView?.favoriteCharacterTextField ?? UITextField(),
                                          userImage: profileView?.userImageView ?? UIImageView())
    }
    
    private func updateEditButton() {
        if editButton {
            profileView?.editButton.setTitle("Save", for: .normal)
            profileView?.nameTextField.isUserInteractionEnabled = true
            profileView?.favoriteCharacterTextField.isUserInteractionEnabled = true
            editButton = false
        } else {
            profileView?.editButton.setTitle("Edit", for: .normal)
            profileView?.nameTextField.isUserInteractionEnabled = false
            profileView?.emailTextField.isUserInteractionEnabled = false
            profileView?.favoriteCharacterTextField.isUserInteractionEnabled = false
            editButton = true
            getPreviousViewController()
        }
    }
    
    private func getPreviousViewController() {
        let viewControllers = navigationController?.viewControllers
        let vcCount = viewControllers?.count ?? 0
        
        if vcCount > 1 {
            if viewControllers?[vcCount - 2] is RegisterViewController {
                viewModel.saveAllUserDataTogether(image: profileView?.userImageView.image ?? UIImage(), name: profileView?.nameTextField.text ?? "", email: profileView?.emailTextField.text ?? "", favoriteCharacter: profileView?.favoriteCharacterTextField.text ?? "")
            } else {
                viewModel.updateUserProfileInFirebase(name: profileView?.nameTextField.text ?? "", email: profileView?.emailTextField.text ?? "", favoriteCharacter: profileView?.favoriteCharacterTextField.text ?? "")
            }
        }
    }
}

//MARK: - ProfileViewDelegate

extension ProfileViewController: ProfileViewDelegate {
    func actionEditUserPictureButton() {
        addPicture()
    }
    
    func actionEditButton() {
        updateEditButton()
    }
    
    func actionLogoutButton() {
        // alert confirmar sair
        let vc: LoginViewController = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionDeleteAccountButton() {
        // alert confirmar deletar
        currentUser?.delete()
        let vc: LoginViewController = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileView?.userImageView.image = pickedImage
            profileView?.userImageView.clipsToBounds = true
            profileView?.userImageView.contentMode = .scaleAspectFill
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func addPicture() {
        pickerController.allowsEditing = false
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
}
