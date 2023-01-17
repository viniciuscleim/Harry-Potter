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
    
    func getHouseColor(type: String) -> UIColor {
        switch type {
        case "Gryffindor":
            return UIColor(red: 84/255, green: 0/255, blue: 9/255, alpha: 1.0)
        case "Slytherin":
            return UIColor(red: 0/255, green: 79/255, blue: 34/255, alpha: 1.0)
        case "Ravenclaw":
            return UIColor(red: 48/255, green: 68/255, blue: 101/255, alpha: 1.0)
        default:
            return UIColor(red: 205/255, green: 156/255, blue: 43/255, alpha: 1.0)
        }
    }
    
    func getHouseTypeImage(type: String) -> UIImage {
        switch type {
        case "Gryffindor":
            return UIImage(named: "grifinoriaLogoM") ?? UIImage()
        case "Slytherin":
            return UIImage(named: "sonserinaLogoM") ?? UIImage()
        case "Ravenclaw":
            return UIImage(named: "covinalLogoM") ?? UIImage()
        default:
            return UIImage(named: "lufalufaLogoM") ?? UIImage()
        }
    }
}
