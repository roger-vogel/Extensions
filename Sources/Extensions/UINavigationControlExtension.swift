//
//  PRNavigationControlExtension.swift
//  Starfish Constellation
//
//  Created by Roger Vogel on 2/25/22.
//

import Foundation
import UIKit

public extension UINavigationController {
    
    // MARK: - METHODS
    
    func addCustomBackButton(title: String = "Back") {
        
        let backButton = UIBarButtonItem()
        backButton.title = title
        navigationBar.topItem!.backBarButtonItem = backButton
    }
}
