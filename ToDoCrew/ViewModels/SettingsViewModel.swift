//
//  SettingsViewModel.swift
//  ToDoCrew
//
//  Created by Petar  on 13.2.25..
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var currentIconIndex: Int
    @Published var currentTheme: Theme
    private let themeManager: ThemeManager
    private let iconNames: [String]
    
    //MARK: - Init
    init(themeManager: ThemeManager, iconNames: [String], currentIconIndex: Int) {
        self.themeManager = themeManager
        self.iconNames = iconNames
        self.currentIconIndex = currentIconIndex
        self.currentTheme = themeManager.current
    }
}

//MARK: - Public API
extension SettingsViewModel {
    
    //MARK: - Methods
    func updateAppIcon() {
        guard iconNames.indices.contains(currentIconIndex) else { return }
        UIApplication.shared.setAlternateIconName(iconNames[currentIconIndex]) { error in
            if let error = error {
                print("Failed to change app icon: \(error.localizedDescription)")
            }
        }
    }
    
    func updateTheme(to theme: Theme) {
        themeManager.current = theme
        currentTheme = theme
    }
}
