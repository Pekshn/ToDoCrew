//
//  ThemeSettings.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

class ThemeSettings: ObservableObject {
    
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}
