//
//  GenericRequest.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 13/01/23.
//

import Foundation

protocol GenericRequest: AnyObject {
    typealias completion <T> = (_ result: T, _ failure: Error?) -> Void
}

enum Error: Swift.Error {
    case errorDescription(message: String, error: Swift.Error? = nil)
}
