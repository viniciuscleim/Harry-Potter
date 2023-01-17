//
//  LoginView.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 09/01/23.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func actionForgotPasswordButton()
    func actionSeePasswordButton()
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
        image.image = UIImage(named: "logo")
        image.tintColor = .orange
        image.contentMode = .scaleAspectFill
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
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var seePasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapSeePasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Esqueceu a senha?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 177/255, blue: 53/255, alpha: 1.0)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)]
        let boldAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "Ainda não tem conta?", attributes: attributes)
        attributedTitle.append(NSAttributedString(string: " Cadastre-se", attributes: boldAttributes))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
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
    
    @objc private func didTapForgotPasswordButton() {
        delegate?.actionForgotPasswordButton()
    }
    
    @objc private func didTapSeePasswordButton() {
        delegate?.actionSeePasswordButton()
    }
    
    @objc private func didTapSignInButton() {
        delegate?.actionSignInButton()
    }
    
    @objc private func didTapRegisterButton() {
        delegate?.actionRegisterButton()
    }
    
    public func setupTextFieldDelegate(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTexField.delegate = delegate
    }

    private func addElements() {
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTexField)
        addSubview(seePasswordButton)
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
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTexField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTexField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordTexField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordTexField.heightAnchor.constraint(equalToConstant: 40),
            
            seePasswordButton.centerYAnchor.constraint(equalTo: passwordTexField.centerYAnchor),
            seePasswordButton.trailingAnchor.constraint(equalTo: passwordTexField.trailingAnchor, constant: -5),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTexField.bottomAnchor, constant: 10),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
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
