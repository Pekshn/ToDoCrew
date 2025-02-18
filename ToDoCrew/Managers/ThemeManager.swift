//
//  ThemeManager.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

class ThemeManager: ObservableObject {
    
    //MARK: - Properties
    static let shared = ThemeManager()
    @Published var current: Theme
    private let storage: UserDefaults

    //MARK: - Init
    init(storage: UserDefaults = .standard) {
        self.storage = storage
        let savedTheme = storage.string(forKey: Constants.themeKey)
        self.current = Theme(rawValue: savedTheme ?? Theme.pink.rawValue) ?? .pink
    }
}

//MARK: - Public API
extension ThemeManager {
    
    func updateTheme(_ newTheme: Theme) {
        current = newTheme
        storage.setValue(newTheme.rawValue, forKey: Constants.themeKey)
    }
}
