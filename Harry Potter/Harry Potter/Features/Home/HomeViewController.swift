//
//  HomeViewController.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 10/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeView: HomeView?
    let viewModel: HomeViewModel = HomeViewModel()
    var alert: Alert?
    var isError: Bool = false
    var isEmpty: Bool {
        return viewModel.filterCharacteresToTextField.count == 0
    }
    
    override func loadView() {
        homeView = HomeView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 83/255, green: 17/255, blue: 27/255, alpha: 1.0)
        homeView?.setupCollectionViewDelegate(delegate: self, dataSource: self)
        homeView?.setupTextFieldDelegate(delegate: self)
        viewModel.setHomeViewModelDelegate(delegate: self)
        viewModel.makeRequest()
        alert = Alert(controller: self)
        startLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        viewModel.userFavorites = []
        viewModel.getFavoritesFromFirebase()
        
    }
    
    func startLoading() {
        homeView?.loadingView.isHidden = false
        homeView?.gifImageView.isHidden = false
    }
    
    func stopLoading() {
        homeView?.loadingView.isHidden = true
        homeView?.gifImageView.isHidden = true
    }
}

//MARK: - HomeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func successRequest() {
        DispatchQueue.main.async {
            self.homeView?.collectionView.reloadData()
            self.stopLoading()
        }
    }
    
    func errorRequest() {
        DispatchQueue.main.async {
            self.isError = true
            self.homeView?.collectionView.reloadData()
            self.stopLoading()
        }
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isError || isEmpty {
            return 1
        } else {
            return viewModel.numberOfItensInSection
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isError {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorCollectionViewCell.identifier, for: indexPath) as? ErrorCollectionViewCell
            cell?.setErrorCollectionViewCellDelegate(delegate: self)
            return cell ?? UICollectionViewCell()
        } else if isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.identifier, for: indexPath) as? EmptyCollectionViewCell
            cell?.isUserInteractionEnabled = false
            cell?.setupCell(type: .empty)
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
            cell?.setupCell(character: viewModel.filterCharacteresToTextField[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.size.width - 30
        
        if isError {
            return CGSize(width: size, height: 200)
        } else {
            return CGSize(width: size, height: 110)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isError {
            let vc: CharacterDetailsViewController = CharacterDetailsViewController()
            vc.characteres = viewModel.filterCharacteres
            vc.index = indexPath.row
            if viewModel.userFavorites.contains(viewModel.filterCharacteres[indexPath.row].name) {
                vc.viewModel.isCharacterFavorite = true
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - UITextFieldDelegate

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let updatedtext = text.replacingCharacters(in: range, with: string)
            viewModel.setSearchTextField(text: updatedtext)
            homeView?.collectionView.reloadData()
        }
        return true
    }
}

//MARK: - ErrorCollectionViewCellDelegate

extension HomeViewController: ErrorCollectionViewCellDelegate {
    func actionTryAgainButton() {
        isError = false
        viewModel.makeRequest()
        startLoading()
    }
}
