//
//  CharacterDetailsView.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 11/01/23.
//

import UIKit

protocol CharacterDetailsViewDelegate: AnyObject {
    func actionReturnButton()
    func actionFavoriteButton()
}

class CharacterDetailsView: UIView {
    
    weak private var delegate: CharacterDetailsViewDelegate?
    
    func setDelegate(delegate: CharacterDetailsViewDelegate?) {
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
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.text = "Harry Potter"
        label.textAlignment = .center
        return label
    }()
    
    lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var houseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "House:"
        return label
    }()
    
    lazy var houseTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Gryffindor"
        return label
    }()
    
    lazy var ancestryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Ancestry:"
        return label
    }()
    
    lazy var ancestryTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Half-blood"
        return label
    }()
    
    lazy var wandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Wand:"
        return label
    }()
    
    lazy var wandTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Holly"
        return label
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
    
    @objc private func didTapFavoriteButton() {
        delegate?.actionFavoriteButton()
    }
    
    private func addElements() {
        addSubview(returnButton)
        addSubview(favoriteButton)
        addSubview(characterNameLabel)
        addSubview(characterImageView)
        addSubview(houseLabel)
        addSubview(houseTypeLabel)
        addSubview(ancestryLabel)
        addSubview(ancestryTypeLabel)
        addSubview(wandLabel)
        addSubview(wandTypeLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            returnButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            returnButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            returnButton.heightAnchor.constraint(equalToConstant: 35),
            
            favoriteButton.centerYAnchor.constraint(equalTo: returnButton.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 35),
            
            characterNameLabel.topAnchor.constraint(equalTo: returnButton.bottomAnchor, constant: 25),
            characterNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            characterNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            characterImageView.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 30),
            characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 150),
            characterImageView.widthAnchor.constraint(equalToConstant: 150),
            
            houseLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 34),
            houseLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            houseTypeLabel.topAnchor.constraint(equalTo: houseLabel.bottomAnchor, constant: 10),
            houseTypeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            ancestryLabel.topAnchor.constraint(equalTo: houseTypeLabel.bottomAnchor, constant: 10),
            ancestryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            ancestryTypeLabel.topAnchor.constraint(equalTo: ancestryLabel.bottomAnchor, constant: 10),
            ancestryTypeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            wandLabel.topAnchor.constraint(equalTo: ancestryTypeLabel.bottomAnchor, constant: 10),
            wandLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            wandTypeLabel.topAnchor.constraint(equalTo: wandLabel.bottomAnchor, constant: 10),
            wandTypeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }
}
