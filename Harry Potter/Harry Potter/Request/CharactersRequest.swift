//
//  CharactersRequest.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 13/01/23.
//

import Foundation

protocol CharactersRequestProtocol: GenericRequest {
    func getCharacteres(completion: @escaping completion<Characteres?>)
}

class CharactersRequest: CharactersRequestProtocol {
    func getCharacteres(completion: @escaping completion<Characteres?>) {
        let urlString: String = "https://hp-api.onrender.com/api/characters"
        
        guard let url: URL = URL(string: urlString) else {
            return completion(nil, Error.errorDescription(message: "Erro de URL"))
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data else {
                return completion(nil, Error.errorDescription(message: "Sem data"))
            }
            
            _ = try? JSONSerialization.jsonObject(with: data)
            
            guard let response = response as? HTTPURLResponse else {
                return completion(nil, Error.errorDescription(message: "Falha conversão HTTPURLResponse"))
            }
            
            if response.statusCode == 200 {
                do {
                    let decodedData = try JSONDecoder().decode([Charactere].self, from: data)
                    completion(decodedData, nil)
                } catch {
                    completion(nil, Error.errorDescription(message: "Deu ruim no PARSE", error: error))
                    print(error)
                }
            } else {
                completion(nil, Error.errorDescription(message: "Deu ruim", error: error))
            }
        }
        task.resume()
    }
}
