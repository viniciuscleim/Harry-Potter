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
    
    override func loadView() {
        homeView = HomeView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        homeView?.setupCollectionViewDelegate(delegate: self, dataSource: self)
        viewModel.setHomeViewModelDelegate(delegate: self)
        viewModel.makeRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}

//MARK: - HomeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func successRequest() {
        DispatchQueue.main.async {
            self.homeView?.collectionView.reloadData()
        }
    }
    
    func errorRequest() {
        // alert de erro na request
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItensInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
        cell?.setupCell(data: viewModel.filterCharacteres[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.size.width - 30
        return CGSize(width: size, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: CharacterDetailsViewController = CharacterDetailsViewController()
        vc.characteres = viewModel.filterCharacteres
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
