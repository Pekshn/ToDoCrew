//
//  Theme.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

enum Theme: String, CaseIterable {
    case pink
    case blue
    case green
    
    //MARK: - Properties
    var color: Color {
        switch self {
        case .pink: return .pink
        case .blue: return .blue
        case .green: return .green
        }
    }
    
    var title: String {
        switch self {
        case .pink: return Localization.pinkTheme
        case .blue: return Localization.blueTheme
        case .green: return Localization.greenTheme
        }
    }
}
