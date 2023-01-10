//
//  RegisterView.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 21/11/22.
//

import UIKit

protocol RegisterViewDelegate: AnyObject {
    func actionReturnButton()
}

class RegisterView: UIView {
    
    weak private var delegate: RegisterViewDelegate?
    
    func setDelegate(delegate: RegisterViewDelegate?) {
        self.delegate = delegate
    
    lazy var returnButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(35)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bem Vindo"
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.keyboardType = .emailAddress
        textField.placeholder = "Digite seu email"
        textField.autocapitalizationType = .none
        textField.textColor = .black
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.keyboardType = .emailAddress
        textField.placeholder = "Digite sua senha"
        textField.autocapitalizationType = .none
        textField.textColor = .black
        return textField
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.keyboardType = .emailAddress
        textField.placeholder = "Confirme sua senha"
        textField.autocapitalizationType = .none
        textField.textColor = .black
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setupConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        @objc private func didTapReturnButton() {
            delegate?.actionReturnButton()
        
    }
    
    private func addElements() {
        addSubview(returnButton)
        addSubview(welcomeLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(registerButton)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            returnButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            returnButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            returnButton.heightAnchor.constraint(equalToConstant: 40),
            
            welcomeLabel.topAnchor.constraint(equalTo: returnButton.bottomAnchor, constant: 0),
            welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            emailTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 50),
            registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            registerButton.heightAnchor.constraint(equalToConstant: 70),
            
            
            
            
            
            
            
            
        ])
        
        
    }
    
}
                            
