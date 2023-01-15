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
    var isThereAnyFavorite: Bool = true
    
    let viewModel: FavoritesViewModel = FavoritesViewModel()
    
    override func loadView() {
        favoritesView = FavoritesView()
        view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        favoritesView?.setupTableViewDelegate(delegate: self, dataSource: self)
        viewModel.setFavoritesViewModelDelegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isThereAnyFavorite = true
        viewModel.userFavorites = []
        viewModel.filterCharacteres = []
        viewModel.getFavoritesFromFirebase()
    }
}

//MARK: - FavoritesViewModelDelegate

extension FavoritesViewController: FavoritesViewModelDelegate {
    func successRequest() {
        DispatchQueue.main.async {
            self.favoritesView?.tableView.reloadData()
        }
    }
    
    func errorRequest() {
        //alert erro
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterCharacteres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell
        cell?.setupCell(character: viewModel.filterCharacteres[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: CharacterDetailsViewController = CharacterDetailsViewController()
        vc.characteres = viewModel.filterCharacteres
        vc.index = indexPath.row
        
        if viewModel.userFavorites.contains(viewModel.filterCharacteres[indexPath.row].name) {
            vc.viewModel.isCharacterFavorite = true
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
