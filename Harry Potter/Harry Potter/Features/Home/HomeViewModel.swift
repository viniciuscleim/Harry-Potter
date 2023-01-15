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
    var favoritesCharacteres: [FavoriteCharacter] = []
    var userFavorites: [String] = []
    var isThereAnyFavorites: Bool = true
    var isFirstLoggin: Bool = false
    
    weak private var delegate: HomeViewModelDelegate?
    
    public func setHomeViewModelDelegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
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
            print("USER\(userFavorites)")
        }
    }
    
    private func getUserIndex(email: String) -> Int {
        let index = favoritesCharacteres.firstIndex { $0.email == email}
        
        if index == nil {
            isThereAnyFavorites = false
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
                self.delegate?.successRequest()
            } else {
                self.delegate?.errorRequest()
            }
        }
    }
    
    public var numberOfItensInSection: Int {
        return filterCharacteres.count
    }
}
