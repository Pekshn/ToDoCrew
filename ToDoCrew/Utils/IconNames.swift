//
//  IconNames.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

class IconNames: ObservableObject {
    
    //MARK: - Properties
    var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    //MARK: - Init
    init() {
        getAlternateIconNames()
        if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    //MARK: - Get alternate icon names
    func getAlternateIconNames() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            for (_, value) in alternateIcons {
                guard let iconList = value as? Dictionary<String, Any> else { return }
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { return }
                guard let icon = iconFiles.first else { return }
                iconNames.append(icon)
            }
        }
    }
}
