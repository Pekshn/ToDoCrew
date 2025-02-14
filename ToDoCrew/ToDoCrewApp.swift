//
//  ToDoCrewApp.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

@main
struct ToDoCrewApp: App {
    
    //MARK: - Properties
    private let persistenceController = PersistenceController.shared
    private let iconNames = IconManager()
    
    //MARK: - Bodys
    var body: some Scene {
        WindowGroup {
            ContentView(viewContext: persistenceController.container.viewContext)
                .environmentObject(iconNames)
                .environmentObject(ThemeManager.shared)
        }
    }
}
