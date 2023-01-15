//
//  FavoritesTableViewCell.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 12/01/23.
//

import UIKit
import AlamofireImage

class FavoritesTableViewCell: UITableViewCell {
    
    static let identifier: String = "FavoritesTableViewCell"
    
    lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "Harry Potter"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElements()
        setUpConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(character: Charactere) {
        let url = URL(string: character.image) ?? URL(fileURLWithPath: "")
        characterImageView.af.setImage(withURL: url)
        
        characterNameLabel.text = character.name
    }
    
    private func addElements() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(characterNameLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 80),
            characterImageView.widthAnchor.constraint(equalToConstant: 60),
            
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20),
            characterNameLabel.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor)
            
        ])
    }
}
