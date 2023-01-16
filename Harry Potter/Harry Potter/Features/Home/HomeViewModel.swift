//
//  HomeViewModel.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 13/01/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol HomeViewModelDelegate: AnyObject {
    func successRequest()
    func errorRequest()
}

class HomeViewModel {
    
    let firebaseFirestore = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    let request: CharactersRequest = CharactersRequest()
    
    var characteres: [Charactere] = []
    var filterCharacteres: [Charactere] = []
    var filterCharacteresToTextField: [Charactere] = []
    var favoritesCharacteres: [FavoriteCharacter] = []
    var userFavorites: [String] = []
    var isThereAnyFavorites: Bool = true
    
    weak private var delegate: HomeViewModelDelegate?
    
    public func setHomeViewModelDelegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func setSearchTextField(text: String) {
        if text.isEmpty {
            self.filterCharacteresToTextField = self.filterCharacteres
        } else {
            self.filterCharacteresToTextField = self.filterCharacteres.filter({
                let test = ($0.name).lowercased().contains(text.lowercased())
                return test
            })
        }
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
    
    public func makeRequest() {
        request.getCharacteres { success, error in
            if let success {
                self.characteres = success
                for charactere in self.characteres {
                    if charactere.image != "" {
                        self.filterCharacteres.append(charactere)
                    }
                }
                self.filterCharacteresToTextField = self.filterCharacteres
                self.delegate?.successRequest()
            } else {
                self.delegate?.errorRequest()
            }
        }
    }
    
    public var numberOfItensInSection: Int {
        return filterCharacteresToTextField.count
    }
}
