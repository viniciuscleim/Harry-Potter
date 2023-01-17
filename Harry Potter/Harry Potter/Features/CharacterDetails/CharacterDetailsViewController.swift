//
//  CharacterDetailsViewController.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 11/01/23.
//

import UIKit
import AlamofireImage

class CharacterDetailsViewController: UIViewController {
    
    var characterDetailsView: CharacterDetailsView?
    var characteres: [Charactere] = []
    var index: Int = 0
    let viewModel: CharacterDetailsViewModel = CharacterDetailsViewModel()
    
    override func loadView() {
        characterDetailsView = CharacterDetailsView()
        view = characterDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailsView?.setDelegate(delegate: self)
        setupUI(data: characteres)
        viewModel.createFavoritesCollectionInFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.isFavorite(viewModel.isCharacterFavorite, button: characterDetailsView?.favoriteButton ?? UIButton())
    }
    
    func setupUI(data: [Charactere?]) {
        view.backgroundColor = viewModel.getHouseColor(type: data[index]?.house.rawValue ?? "")
        
        let url = URL(string: data[index]?.image ?? "") ?? URL(fileURLWithPath: "")
        characterDetailsView?.characterImageView.af.setImage(withURL: url)
        
        characterDetailsView?.characterNameLabel.text = data[index]?.name
        
        if data[index]?.house.rawValue.capitalized == "" {
            characterDetailsView?.houseTypeLabel.text = "Unknown"
        } else {
            characterDetailsView?.houseTypeLabel.text = data[index]?.house.rawValue.capitalized
        }
        
        if data[index]?.ancestry.rawValue.capitalized == "" {
            characterDetailsView?.ancestryTypeLabel.text = "Unknown"
        } else {
            characterDetailsView?.ancestryTypeLabel.text = data[index]?.ancestry.rawValue.capitalized
        }
        
        if data[index]?.wand.wood.rawValue.capitalized == "" {
            characterDetailsView?.wandTypeLabel.text = "Unknown"
        } else {
            characterDetailsView?.wandTypeLabel.text = data[index]?.wand.wood.rawValue.capitalized
        }
        
        characterDetailsView?.houseImageView.image = viewModel.getHouseTypeImage(type: data[index]?.house.rawValue ?? "")
    }
}

//MARK: - CharacterDetailsViewDelegate

extension CharacterDetailsViewController: CharacterDetailsViewDelegate {
    func actionReturnButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func actionFavoriteButton() {
        viewModel.favoriteButtonConfig(button: characterDetailsView?.favoriteButton ?? UIButton(), character: characterDetailsView?.characterNameLabel.text ?? "")
    }
}
