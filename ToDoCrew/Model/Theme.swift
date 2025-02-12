//
//  Theme.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

enum Theme: String, CaseIterable {
    case pink = "Pink theme"
    case blue = "Blue theme"
    case green = "Green theme"
    
    //MARK: - Properties
    var color: Color {
        switch self {
        case .pink: return .pink
        case .blue: return .blue
        case .green: return .green
        }
    }
}
