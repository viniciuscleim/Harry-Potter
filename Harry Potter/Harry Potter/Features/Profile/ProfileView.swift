//
//  ProfileView.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 12/01/23.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func actionEditUserPictureButton()
    func actionEditButton()
    func actionLogoutButton()
    func actionDeleteAccountButton()
}

class ProfileView: UIView {
    
    weak private var delegate: ProfileViewDelegate?
    
    func setDelegate(delegate: ProfileViewDelegate) {
        self.delegate = delegate
    }
    
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Profile"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(24)
        label.textColor = .black
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    lazy var userImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var editUserPictureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Edit Picture", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapEditPictureButton), for: .touchUpInside)
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(18)
        label.textColor = .black
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .default
        textField.textColor = .darkGray
        textField.isUserInteractionEnabled = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(18)
        label.textColor = .black
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .default
        textField.textColor = .darkGray
        textField.isUserInteractionEnabled = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var favoriteCharacterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Favorite Character:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(18)
        label.textColor = .black
        return label
    }()
    
    lazy var favoriteCharacterTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .default
        textField.textColor = .darkGray
        textField.isUserInteractionEnabled = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        return button
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Delete account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(didTapDeleteAccountButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapEditPictureButton() {
        delegate?.actionEditUserPictureButton()
    }
    
    @objc private func didTapEditButton() {
        delegate?.actionEditButton()
    }
    
    @objc private func didTapLogoutButton() {
        delegate?.actionLogoutButton()
    }
    
    @objc private func didTapDeleteAccountButton() {
        delegate?.actionDeleteAccountButton()
    }
    
    private func addElements() {
        addSubview(profileLabel)
        addSubview(lineView)
        addSubview(userImageView)
        addSubview(editUserPictureButton)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(favoriteCharacterLabel)
        addSubview(favoriteCharacterTextField)
        addSubview(editButton)
        addSubview(logoutButton)
        addSubview(deleteAccountButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
           
            profileLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            profileLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            lineView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 4),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            userImageView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16),
            userImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 80),
            userImageView.widthAnchor.constraint(equalToConstant: 80),
            
            editUserPictureButton.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            editUserPictureButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            editUserPictureButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            nameLabel.topAnchor.constraint(equalTo: editUserPictureButton.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            favoriteCharacterLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            favoriteCharacterLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            favoriteCharacterTextField.topAnchor.constraint(equalTo: favoriteCharacterLabel.bottomAnchor, constant: 10),
            favoriteCharacterTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            favoriteCharacterTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            editButton.topAnchor.constraint(equalTo: favoriteCharacterTextField.bottomAnchor, constant: 22),
            editButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            editButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 38),
            
            logoutButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 22),
            logoutButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 38),
            
            deleteAccountButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 22),
            deleteAccountButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            deleteAccountButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 38)
            
        ])
    }
}
