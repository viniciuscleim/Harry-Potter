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
    
    public func saveAllUserDataTogether(image: UIImage, name: String, email: String, favoriteCharacter: String) {
        guard let image = image.jpegData(compressionQuality: 0.8) else {return}
        
        let imagePath = "userImages/\(currentUser?.uid ?? "").jpg"
        
        let imageRef = storage.child(imagePath)
        
        imageRef.putData(image, metadata: nil) { metadata, error in
            
            if error == nil && metadata != nil {
                imageRef.downloadURL { url, error in
                    if error == nil{
                        if let urlImagem = url?.absoluteString{
                            self.saveUserProfileInFirebase(name: name, email: email, favoriteCharacter: favoriteCharacter, userImage: urlImagem, id: self.currentUser?.uid ?? "")
                        }
                    }else{
                        //alert deu erro
                        print("ERRO")
                    }
                }
            }else{
                //alert deu erro
            }
        }
    }
    
    public func updateUserProfileInFirebase(name: String, email: String, favoriteCharacter: String) {
        let docPath = "userData/\(currentUser?.uid ?? "")"
        let docReference = firebaseFirestore.document(docPath)
        docReference.updateData([
            "name": name,
            "email": email,
            "favoriteCharacter": favoriteCharacter
        ])
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
                            //alert informando a importancia de preencher o perfil
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
        let index = userData.firstIndex { $0.email == currentUser?.email } ?? 10
        print(index)
        return index
    }
}
