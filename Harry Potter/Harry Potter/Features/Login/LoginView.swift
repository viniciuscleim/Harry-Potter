//
//  LoginView.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 09/01/23.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func actionForgotPasswordButton()
    func actionSignInButton()
    func actionRegisterButton()
}

class LoginView: UIView {
    
    weak private var delegate: LoginViewDelegate?
    
    func setDelegate(delegate: LoginViewDelegate?) {
        self.delegate = delegate
    }
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "bolt")
        image.tintColor = .orange
        image.contentMode = .scaleAspectFit
        return image
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
        textField.text = "vini@hotmail.com"
        return textField
    }()
    
    lazy var passwordTexField: UITextField = {
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
        textField.text = "123456"
        return textField
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Esqueceu a senha?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Nao tem conta? Cadastra-se", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
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
        
    }
    
    @objc private func didTapForgotPasswordButton() {
        delegate?.actionForgotPasswordButton()
    }
    
    @objc private func didTapSignInButton() {
        delegate?.actionSignInButton()
    }
    
    @objc private func didTapRegisterButton() {
        delegate?.actionRegisterButton()
    }

    private func addElements() {
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTexField)
        addSubview(forgotPasswordButton)
        addSubview(signInButton)
        addSubview(registerButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTexField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTexField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            passwordTexField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            passwordTexField.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTexField.bottomAnchor, constant: 20),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 50),
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            signInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            signInButton.heightAnchor.constraint(equalToConstant: 70),
            
            registerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
}
