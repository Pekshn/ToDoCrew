//
//  UIApplication.swift
//  ToDoCrew
//
//  Created by Petar  on 13.2.25..
//

import SwiftUI

extension UIApplication: AppIconChanger {
    
    //MARK: - Properties
    var alternateIconName: String? {
        self.value(forKey: "alternateIconName") as? String
    }
    
    //MARK: - Methods
    func setAlternateIconName(_ iconName: String?, completion: @escaping (Error?) -> Void) {
        self.performSelector(onMainThread: #selector(UIApplication.setAlternateIconName(_:completionHandler:)), with: iconName, waitUntilDone: false)
    }
}
