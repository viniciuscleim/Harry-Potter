//
//  FavoritesViewController.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 12/01/23.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favoritesView: FavoritesView?
    var favoritesCharacteres: [FavoriteCharacter] = []
    var alert: Alert?
    
    let viewModel: FavoritesViewModel = FavoritesViewModel()
    
    override func loadView() {
        favoritesView = FavoritesView()
        view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 83/255, green: 17/255, blue: 27/255, alpha: 1.0)
        favoritesView?.setupCollectionViewDelegate(delegate: self, dataSource: self)
        viewModel.setFavoritesViewModelDelegate(delegate: self)
        alert = Alert(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.userFavorites = []
        viewModel.filterCharacteres = []
        viewModel.getFavoritesFromFirebase()
        startLoading()
    }
    
    func startLoading() {
        favoritesView?.loadingView.isHidden = false
        favoritesView?.gifImageView.isHidden = false
    }
    
    func stopLoading() {
        favoritesView?.loadingView.isHidden = true
        favoritesView?.gifImageView.isHidden = true
    }
}

//MARK: - FavoritesViewModelDelegate

extension FavoritesViewController: FavoritesViewModelDelegate {
    func successRequest() {
        DispatchQueue.main.async {
            self.favoritesView?.collectionView.reloadData()
            self.stopLoading()
        }
    }
    
    func errorRequest() {
        alert?.configAlert(title: "Ops", message: "Tivemos um problema no nosso servidor, tente novamente!")
        stopLoading()
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.userFavorites.count == 0 {
            return 1
        } else {
            return viewModel.filterCharacteres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if viewModel.userFavorites.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.identifier, for: indexPath) as? EmptyCollectionViewCell
            cell?.isUserInteractionEnabled = false
            cell?.setupCell(type: .notFound)
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
            cell?.setupCell(character: viewModel.filterCharacteres[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.size.width - 30
        
        if viewModel.userFavorites.count == 0 {
            return CGSize(width: size, height: 170)
        } else {
            return CGSize(width: size, height: 110)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: CharacterDetailsViewController = CharacterDetailsViewController()
        vc.characteres = viewModel.filterCharacteres
        vc.index = indexPath.row
        vc.viewModel.isCharacterFavorite = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
