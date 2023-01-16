//
//  HouseType.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 11/01/23.
//

import Foundation

//MARK: - HouseType

enum HouseType: String {
    case Gryffindor = "Gryffindor"
    case Slytherin = "Slytherin"
    case Ravenclaw = "Ravenclaw"
    case Hufflepuff = "Hufflepuff"
}

//MARK: - FirebaseRequestType

enum FirebaseRequestType {
    case save
    case update
}

//MARK: - PasswordType

enum PasswordType {
    case password
    case confirmPassword
}
