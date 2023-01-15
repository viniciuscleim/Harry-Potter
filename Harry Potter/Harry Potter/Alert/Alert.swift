//
//  Alert.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 15/01/23.
//

import UIKit

class Alert: NSObject {
    
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func configAlert(title: String, message: String, completion:(() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Ok", style: .cancel) { action in
            completion?()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { action in
            self.controller.dismiss(animated: true)
        }
        
        alertController.addAction(cancel)
        alertController.addAction(confirm)
        
        controller.present(alertController, animated: true, completion: nil)
    }
}
