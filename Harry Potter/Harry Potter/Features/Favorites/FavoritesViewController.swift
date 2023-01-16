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
        view.backgroundColor = .white
        favoritesView?.setupTableViewDelegate(delegate: self, dataSource: self)
        viewModel.setFavoritesViewModelDelegate(delegate: self)
        alert = Alert(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        alert?.configAlert(title: "Ops", message: "Tivemos um problema no nosso servidor, tente novamente!")
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
        vc.viewModel.isCharacterFavorite = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
