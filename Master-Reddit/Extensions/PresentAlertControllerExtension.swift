//
//  PresentAlertControllerExtension.swift
//  Master-Reddit
//
//  Created by Cameron Stuart on 4/29/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        
        let alertController = UIAlertController(title: "ERROR!", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "OK", style: .cancel)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
}
