//
//  FavoritesView.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 12/01/23.
//

import UIKit

class FavoritesView: UIView {
    
    lazy var favoritesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Favorites"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(24)
        label.textColor = .white
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.register(ErrorCollectionViewCell.self, forCellWithReuseIdentifier: ErrorCollectionViewCell.identifier)
        collectionView.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: EmptyCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    lazy var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        return view
    }()
    
    lazy var gifImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        let gifImage = UIImage.gifImageWithName("harrryPomo")
        image.image = gifImage
        image.tintColor = .orange
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCollectionViewDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    private func addElements() {
        addSubview(favoritesLabel)
        addSubview(collectionView)
        addSubview(loadingView)
        addSubview(gifImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoritesLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            favoritesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            favoritesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: favoritesLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            gifImageView.heightAnchor.constraint(equalToConstant: 200),
            gifImageView.widthAnchor.constraint(equalToConstant: 200),
            gifImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gifImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
}
