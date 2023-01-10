//
//  PasswordChangeView.swift
//  SuperTrunfo
//
//  Created by Vinicius Cleim on 09/01/23.
//

import UIKit

protocol PasswordViewDelegate: AnyObject {
    func actionReturnButton()
    func actionSendEmailButton()
}

class PasswordChangeView: UIView {
    
    weak private var delegate: PasswordViewDelegate?
    
    func setDelegate(delegate: PasswordViewDelegate?) {
        self.delegate = delegate
    }
    
    lazy var returnButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.addTarget(self, action: #selector(didTapReturnButton), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var passwordChangeLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Use seu email cadastrado para recuperar a senha:"
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
    
    lazy var sendEmailButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(didTapSendEmailButton), for: .touchUpInside)
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
    
    @objc private func didTapSendEmailButton() {
        delegate?.actionSendEmailButton()
    }
    
    private func addElements() {
        addSubview(returnButton)
        addSubview(logoImageView)
        addSubview(passwordChangeLabel)
        addSubview(emailTextField)
        addSubview(sendEmailButton)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            returnButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            returnButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            returnButton.heightAnchor.constraint(equalToConstant: 40),
            
            logoImageView.topAnchor.constraint(equalTo: returnButton.bottomAnchor, constant: 10),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            passwordChangeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            passwordChangeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            passwordChangeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            emailTextField.topAnchor.constraint(equalTo: passwordChangeLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            sendEmailButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            sendEmailButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            sendEmailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            sendEmailButton.heightAnchor.constraint(equalToConstant: 70),
            
        ])
    }
}
