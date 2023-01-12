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
    
    override func loadView() {
        favoritesView = FavoritesView()
        view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        favoritesView?.setupTableViewDelegate(delegate: self, dataSource: self)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell
        cell?.setDelegate(delegate: self)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: CharacterDetailsViewController = CharacterDetailsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - FavoritesTableViewCellDelegate

extension FavoritesViewController: FavoritesTableViewCellDelegate {
    func actionFavoriteButton() {
        print(#function)
        // alert confirmar remover dos favoritos
    }
}
