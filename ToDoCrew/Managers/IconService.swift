//
//  IconService.swift
//  ToDoCrew
//
//  Created by Petar  on 14.2.25..
//

import SwiftUI

protocol IconServiceProtocol {
    func setAlternateIconName(_ iconName: String?, completion: @escaping (Error?) -> Void)
    var alternateIconName: String? { get set }
}

class IconService: IconServiceProtocol {
    
    //MARK: - Properties
    var alternateIconName: String? {
        get { UIApplication.shared.alternateIconName }
        set { }
    }
    
    //MARK: - Methods
    func setAlternateIconName(_ iconName: String?, completion: @escaping (Error?) -> Void) {
        UIApplication.shared.setAlternateIconName(iconName, completionHandler: completion)
    }
}
