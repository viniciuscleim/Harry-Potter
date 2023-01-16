//
//  FavoritesViewModel.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 14/01/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol FavoritesViewModelDelegate: AnyObject {
    func successRequest()
    func errorRequest()
}

class FavoritesViewModel {
    
    let firebaseFirestore = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    let request: CharactersRequest = CharactersRequest()
    
    var favoritesCharacteres: [FavoriteCharacter] = []
    var isThereAnyFavorites: Bool = true
    var userFavorites: [String] = []
    var characteres: [Charactere] = []
    var filterCharacteres: [Charactere] = []
    
    weak private var delegate: FavoritesViewModelDelegate?
    
    public func setFavoritesViewModelDelegate(delegate: FavoritesViewModelDelegate) {
        self.delegate = delegate
    }
    
    func favoriteButton(_ isFavorite: Bool, button: UIButton) {
        if isFavorite {
            button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            button.configuration?.baseForegroundColor = UIColor.yellow
        }
    }
    
    func getFavoritesFromFirebase() {
        firebaseFirestore.collection("favorites").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot {
                    DispatchQueue.main.async {
                        self.favoritesCharacteres = snapshot.documents.map({ document in
                            return FavoriteCharacter(character: document["characters"] as? [String] ?? [],
                                                     email: document["email"] as? String ?? ""
                            )
                        })
                        self.getUserFavorites(index: self.getUserIndex(email: self.currentUser?.email ?? ""))
                        self.makeRequest()
                    }
                }
            }
        }
    }
    
    private func getUserFavorites(index: Int) {
        if isThereAnyFavorites == true {
            for favoriteCharactere in favoritesCharacteres[index].character {
                userFavorites.append(favoriteCharactere)
            }
        }
    }
    
    private func getUserIndex(email: String) -> Int {
        let index = favoritesCharacteres.firstIndex { $0.email == email}
        
        if index == nil {
            isThereAnyFavorites = false
        } else {
            isThereAnyFavorites = true
        }
        return index ?? 0
    }
    
    private func makeRequest() {
        request.getCharacteres { success, error in
            if let success {
                self.characteres = success
                for charactere in self.characteres {
                    if self.userFavorites.contains(charactere.name) {
                        self.filterCharacteres.append(charactere)
                    }
                }
                self.delegate?.successRequest()
            } else {
                self.delegate?.errorRequest()
            }
        }
    }
}
