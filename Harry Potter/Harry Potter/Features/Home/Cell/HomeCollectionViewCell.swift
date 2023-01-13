//
//  HomeCollectionViewCell.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 10/01/23.
//

import UIKit
import AlamofireImage

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeCollectionViewCell"
    
    lazy var backGroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setUpConstraints()
        initialConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(data: Charactere) {
        let url = URL(string: data.image) ?? URL(fileURLWithPath: "")
        characterImageView.af.setImage(withURL: url)
        
        characterNameLabel.text = data.name
    }
    
    private func initialConfig() {
        contentView.backgroundColor = .clear
        backGroundView.layer.cornerRadius = 25
        layer.masksToBounds = true
        backGroundView.backgroundColor = .white
        backGroundView.layer.borderWidth = 0.5
        backGroundView.layer.borderColor = UIColor.black.cgColor
        backGroundView.layer.makeShadow(color: .black, x: 0, y: 3, blur: 4, spread: 0)
        
        characterNameLabel.layer.makeShadow(color: .black, x: 0, y: 2, blur: 3, spread: 0)
    }
    
    private func addElements() {
        addSubview(backGroundView)
        addSubview(characterImageView)
        addSubview(characterNameLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            backGroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            backGroundView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            backGroundView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            backGroundView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            characterImageView.heightAnchor.constraint(equalToConstant: 80),
            characterImageView.widthAnchor.constraint(equalToConstant: 60),
            
            characterNameLabel.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10)
            
        ])
    }
}
