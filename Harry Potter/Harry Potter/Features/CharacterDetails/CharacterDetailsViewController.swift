//
//  CharacterDetailsViewController.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 11/01/23.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var characterDetailsView: CharacterDetailsView?
    
    override func loadView() {
        characterDetailsView = CharacterDetailsView()
        view = characterDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailsView?.setDelegate(delegate: self)
    }
    
    private func getHouseColor(type: String) -> UIColor {
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
}

//MARK: - CharacterDetailsViewDelegate

extension CharacterDetailsViewController: CharacterDetailsViewDelegate {
    func actionReturnButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func actionFavoriteButton() {
        print(#function)
    }
}
