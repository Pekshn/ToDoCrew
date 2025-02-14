//
//  SettingsViewModel.swift
//  ToDoCrew
//
//  Created by Petar  on 13.2.25..
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var iconManager: IconManager
    @Published var currentTheme: Theme
    private var cancellables = Set<AnyCancellable>()
    
    private var themeManager: ThemeManager

    // Dependency Injection
    init(iconManager: IconManager, themeManager: ThemeManager) {
        self.iconManager = iconManager
        self.themeManager = themeManager
        self.currentTheme = themeManager.current
        
        themeManager.$current
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newTheme in
                self?.currentTheme = newTheme
            }
            .store(in: &cancellables)
    }
    
    // Methods
    func updateAppIcon(to index: Int) {
        iconManager.updateAppIcon(to: index)
    }
    
    func updateTheme(to theme: Theme) {
        themeManager.updateTheme(theme)
    }
}
