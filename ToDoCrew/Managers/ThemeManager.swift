//
//  ThemeManager.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

class ThemeManager: ObservableObject {
    
    //MARK: - Properties
    @AppStorage("Theme") private var selectedThemeRawValue: String = Theme.pink.rawValue
    var current: Theme {
        get {
            Theme(rawValue: selectedThemeRawValue) ?? .pink
        }
        set {
            selectedThemeRawValue = newValue.rawValue
            objectWillChange.send()
        }
    }
}
