//
//  HomeViewModel.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 13/01/23.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func successRequest()
    func errorRequest()
}

class HomeViewModel {
    
    let request: CharactersRequest = CharactersRequest()
    var characteres: [Charactere] = []
    var filterCharacteres: [Charactere] = []
    
    weak private var delegate: HomeViewModelDelegate?
    
    public func setHomeViewModelDelegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
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
