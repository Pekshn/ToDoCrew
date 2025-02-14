//
//  IconManager.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

class IconManager: ObservableObject {
    
    //MARK: - Properties
    private let userDefaults: UserDefaults
    private let appIconService: IconServiceProtocol
    var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    //MARK: - Init
    init(userDefaults: UserDefaults = .standard, appIconService: IconServiceProtocol = IconService()) {
        self.userDefaults = userDefaults
        self.appIconService = appIconService
        self.getAlternateIconNames()
        if let savedIconName = UserDefaults.standard.string(forKey: Constants.iconKey),
           let savedIndex = iconNames.firstIndex(of: savedIconName) {
            self.currentIndex = savedIndex
        } else if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    //MARK: - Get alternate icon names
    func getAlternateIconNames() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            for (_, value) in alternateIcons {
                guard let iconList = value as? Dictionary<String, Any> else { continue }
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { continue }
                guard let icon = iconFiles.first else { continue }
                iconNames.append(icon)
            }
        }
    }
    
    //MARK: - Update icon
    func updateAppIcon(to index: Int) {
        let newIconName = iconNames[index]
        guard appIconService.alternateIconName != newIconName else { return }
        
        appIconService.setAlternateIconName(newIconName) { error in
            if let error = error {
                print("Error changing app icon: \(error.localizedDescription)")
            } else {
                print("Successfully changed app icon to: \(newIconName ?? "Default")")
                DispatchQueue.main.async {
                    self.currentIndex = index
                    if let newIconName = newIconName {
                        self.userDefaults.setValue(newIconName, forKey: Constants.iconKey)
                    } else {
                        self.userDefaults.removeObject(forKey: Constants.iconKey)
                    }
                }
            }
        }
    }
}
