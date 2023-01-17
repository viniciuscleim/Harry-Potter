//
//  ProfileViewModel.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 14/01/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import AlamofireImage

class ProfileViewModel {
    
    let firebaseFirestore = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    let storage = Storage.storage().reference()
    
    var userData: [UserData] = []
    var isNewUser: Bool = false
    var alert: Alert?
    
    public func setupAlertController(controller: UIViewController) {
        alert = Alert(controller: controller)
    }
    
    private func saveUserProfileInFirebase(name: String, email: String, favoriteCharacter: String, userImage: String, id: String) {
        let docPath = "userData/\(id)"
        let docReference = firebaseFirestore.document(docPath)
        docReference.setData([
            "name": name,
            "email": email,
            "favoriteCharacter": favoriteCharacter,
            "userImage": userImage
        ])
    }
    
    public func saveAllUserDataTogether(image: UIImage, name: String, email: String, favoriteCharacter: String, requestType: FirebaseRequestType) {
        
        guard let image = image.jpegData(compressionQuality: 0.8) else {
            self.saveUserProfileInFirebase(name: name, email: email, favoriteCharacter: favoriteCharacter, userImage: "", id: self.currentUser?.uid ?? "")
            return
        }
        
        let imagePath = "userImages/\(currentUser?.uid ?? "").jpg"
        
        let imageRef = storage.child(imagePath)
        
        imageRef.putData(image, metadata: nil) { metadata, error in
            
            if error == nil && metadata != nil {
                imageRef.downloadURL { url, error in
                    if error == nil{
                        if let urlImagem = url?.absoluteString{
                            
                            switch requestType {
                            case .save:
                                self.saveUserProfileInFirebase(name: name, email: email, favoriteCharacter: favoriteCharacter, userImage: urlImagem, id: self.currentUser?.uid ?? "")
                            case .update:
                                self.updateUserProfileInFirebase(name: name, email: email, favoriteCharacter: favoriteCharacter, userImage: urlImagem)
                            }
                        }
                    }else{
                        self.alert?.configAlert(title: "Ops", message: "Algo deu errado, tente novamente!")
                    }
                }
            }else{
                self.alert?.configAlert(title: "Ops", message: "Algo deu errado, tente novamente!")
            }
        }
    }
    
    private func updateUserProfileInFirebase(name: String, email: String, favoriteCharacter: String, userImage: String) {
        let docPath = "userData/\(currentUser?.uid ?? "")"
        let docReference = firebaseFirestore.document(docPath)
        docReference.updateData([
            "name": name,
            "email": email,
            "favoriteCharacter": favoriteCharacter,
            "userImage": userImage
        ])
    }
    
    public func removeUserDataFromFirebase() {
        firebaseFirestore.collection("userData").getDocuments { snapshot, error in
            if error == nil {
                for _ in snapshot!.documents {
                    self.firebaseFirestore.collection("userData").document(self.currentUser?.uid ?? "").delete { error in
                        if error != nil {
                            self.alert?.configAlert(title: "Ops", message: "Algo deu errado, tente novamente!")
                        } else {
                            DispatchQueue.main.async {
                                self.removeUserFavoritesFromFirebase()
                                self.alert?.configAlert(title: "Sucesso", message: "Sua conta foi deletada. Sentimos muito em vê-lo partir!")
                            }
                        }
                    }
                }
            } else {
                self.alert?.configAlert(title: "Ops", message: "Algo deu errado, tente novamente!")
            }
        }
    }
    
    private func removeUserFavoritesFromFirebase() {
        firebaseFirestore.collection("favorites").getDocuments { snapshot, error in
            if error == nil {
                for _ in snapshot!.documents {
                    self.firebaseFirestore.collection("favorites").document(self.currentUser?.email ?? "").delete { error in
                        if error != nil {
                            self.alert?.configAlert(title: "Ops", message: "Algo deu errado, tente novamente!")
                        } else {
                            DispatchQueue.main.async {
                                self.currentUser?.delete()
                            }
                        }
                    }
                }
            } else {
                self.alert?.configAlert(title: "Ops", message: "Algo deu errado, tente novamente!")
            }
        }
    }
    
    public func getUserDataFromFirebase(nameTF: UITextField, emailTF: UITextField, favoriteTF: UITextField, userImage: UIImageView) {
        
        firebaseFirestore.collection("userData").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot {
                    DispatchQueue.main.async {
                        self.userData = snapshot.documents.map({ document in
                            return UserData(name: document["name"] as? String ?? "",
                                            email: document["email"] as? String ?? "",
                                            favoriteCharacter: document["favoriteCharacter"] as? String ?? "",
                                            userImage: document["userImage"] as? String ?? "")
                        })
                        
                        if self.isNewUser == false {
                            self.setupUI(nameTF: nameTF, emailTF: emailTF, favoriteTF: favoriteTF, userImage: userImage, index: self.getIndex())
                        } else {
                            self.alert?.configAlert(title: "IMPORTANTE", message: "Para uma melhor experiência, preencha os dados solicitados clicando no botão 'Edit'")
                            emailTF.text = self.currentUser?.email
                        }
                    }
                }
            }
        }
    }
    
    private func setupUI(nameTF: UITextField, emailTF: UITextField, favoriteTF: UITextField, userImage: UIImageView, index: Int) {
        nameTF.text = userData[index].name
        emailTF.text = currentUser?.email
        favoriteTF.text = userData[index].favoriteCharacter
        let url = URL(string: userData[index].userImage) ?? URL(fileURLWithPath: "")
        userImage.af.setImage(withURL: url)
    }
    
    private func getIndex() -> Int {
        let index = userData.firstIndex { $0.email == currentUser?.email } ?? 0
        return index
    }
}
