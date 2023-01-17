//
//  RegisterView.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 09/01/23.
//

import UIKit

protocol RegisterViewDelegate: AnyObject {
    func actionReturnButton()
    func actionSeePasswordButton()
    func actionSeeConfirmPasswordButton()
    func actionRegisterButton()
}

class RegisterView: UIView {
    
    weak private var delegate: RegisterViewDelegate?
    
    func setDelegate(delegate: RegisterViewDelegate?) {
        self.delegate = delegate
    }
    
    lazy var returnButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapReturnButton), for: .touchUpInside)
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
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "chapeuSeletor")
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
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var seeConfirmPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapSeeConfirmPasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var wrongPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "As senhas não conferem"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(14)
        label.textColor = .red
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 83/255, green: 17/255, blue: 27/255, alpha: 1.0)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
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
    
    @objc private func didTapReturnButton() {
        delegate?.actionReturnButton()
    }
    
    @objc private func didTapSeePasswordButton() {
        delegate?.actionSeePasswordButton()
    }
    
    @objc private func didTapSeeConfirmPasswordButton() {
        delegate?.actionSeeConfirmPasswordButton()
    }
    
    @objc private func didTapRegisterButton() {
        delegate?.actionRegisterButton()
    }
    
    public func setupTextFieldDelegate(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
        confirmPasswordTextField.delegate = delegate
    }
    
    private func addElements() {
        addSubview(returnButton)
        addSubview(welcomeLabel)
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(seePasswordButton)
        addSubview(confirmPasswordTextField)
        addSubview(seeConfirmPasswordButton)
        addSubview(registerButton)
        addSubview(wrongPasswordLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            returnButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            returnButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            returnButton.heightAnchor.constraint(equalToConstant: 40),
            
            welcomeLabel.topAnchor.constraint(equalTo: returnButton.bottomAnchor, constant: 0),
            welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            logoImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 14),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            seePasswordButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            seePasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -5),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            seeConfirmPasswordButton.centerYAnchor.constraint(equalTo: confirmPasswordTextField.centerYAnchor),
            seeConfirmPasswordButton.trailingAnchor.constraint(equalTo: confirmPasswordTextField.trailingAnchor, constant: -5),
            
            wrongPasswordLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 4),
            wrongPasswordLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            
            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 50),
            registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            registerButton.heightAnchor.constraint(equalToConstant: 70)
            
        ])
    }
}
