//
//  CharacterDetailsViewModel.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 13/01/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class CharacterDetailsViewModel {
    
    var isCharacterFavorite: Bool = false
    let firebaseFirestore = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    
    func isFavorite(_ isFavorite: Bool, button: UIButton) {
        if isFavorite {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isCharacterFavorite = true
        }
    }
    
    func favoriteButtonConfig(button: UIButton, character: String) {
        if isCharacterFavorite == false {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isCharacterFavorite = true
            saveFavoriteCharacterInFirebase(character: character)
        } else {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            isCharacterFavorite = false
            removeFavoriteCharacterInFirebase(character: character)
        }
    }
    
    func createFavoritesCollectionInFirebase() {
        let docPath = "favorites/\(currentUser?.email ?? "")"
        let docReference = firebaseFirestore.document(docPath)
        docReference.getDocument { document, error in
            let favoriteDoc = document?.exists
            if favoriteDoc == false {
                docReference.setData([
                    "characters": [],
                    "email": self.currentUser?.email ?? ""
                ])
            }
        }
    }
    
    private func saveFavoriteCharacterInFirebase(character: String) {
        let docPath = "favorites/\(currentUser?.email ?? "")"
        let docReference = firebaseFirestore.document(docPath)
        docReference.updateData([
            "characters": FieldValue.arrayUnion([character])
        ])
    }
    
    private func removeFavoriteCharacterInFirebase(character: String) {
        firebaseFirestore.collection("favorites").document(currentUser?.email ?? "").updateData([
            "characters": FieldValue.arrayRemove([character])
        ])
    }
}
