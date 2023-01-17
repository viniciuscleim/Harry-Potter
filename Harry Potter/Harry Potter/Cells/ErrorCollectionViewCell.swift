//
//  ErrorCollectionViewCell.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 16/01/23.
//

import UIKit

protocol ErrorCollectionViewCellDelegate: AnyObject {
    func actionTryAgainButton()
}

class ErrorCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ErrorCollectionViewCell"
    
    var delegate: ErrorCollectionViewCellDelegate?
    
    func setErrorCollectionViewCellDelegate(delegate: ErrorCollectionViewCellDelegate) {
        self.delegate = delegate
    }
    
    lazy var errorImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "varinhaQuebrada")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "Ops, algo deu errado. Sentimos muito!"
        return label
    }()
    
    lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tente novamente", for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 177/255, blue: 53/255, alpha: 1.0)
        button.addTarget(self, action: #selector(didTapTryAgainButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapTryAgainButton() {
        delegate?.actionTryAgainButton()
    }
    
    private func addElements() {
        contentView.addSubview(errorImageView)
        contentView.addSubview(errorMessageLabel)
        contentView.addSubview(tryAgainButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            errorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImageView.heightAnchor.constraint(equalToConstant: 80),
            errorImageView.widthAnchor.constraint(equalToConstant: 80),
            
            errorMessageLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 10),
            errorMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            errorMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            tryAgainButton.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: 16),
            tryAgainButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tryAgainButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
        ])
    }
}
