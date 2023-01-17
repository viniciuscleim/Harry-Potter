//
//  EmptyCollectionViewCell.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 16/01/23.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "EmptyCollectionViewCell"
    
    lazy var emptyImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "hpLupa")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        label.text = "Pesonagem não encontrado"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(type: CellType) {
        switch type {
        case .notFound:
            emptyMessageLabel.text = "Não encontrei nenhum favorito"
        case .empty:
            emptyMessageLabel.text = "Pesonagem não encontrado"
        }
    }
    
    private func addElements() {
        contentView.addSubview(emptyImageView)
        contentView.addSubview(emptyMessageLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            emptyImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            emptyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyImageView.heightAnchor.constraint(equalToConstant: 150),
            emptyImageView.widthAnchor.constraint(equalToConstant: 150),
            
            emptyMessageLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 10),
            emptyMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emptyMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
        ])
    }
}
