//
//  EmptyTableViewCell.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 16/01/23.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    static let identifier: String = "EmptyTableViewCell"
    
    lazy var emptyImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "Nenhum pesonagem favorito foi adicionado"
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
    
    private func addElements() {
        contentView.addSubview(emptyImageView)
        contentView.addSubview(emptyMessageLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            emptyImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            emptyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyImageView.heightAnchor.constraint(equalToConstant: 80),
            emptyImageView.widthAnchor.constraint(equalToConstant: 80),
            
            emptyMessageLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 10),
            emptyMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emptyMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
        ])
    }

}
