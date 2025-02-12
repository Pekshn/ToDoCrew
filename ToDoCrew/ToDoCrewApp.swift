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
    @StateObject private var themeManager = ThemeManager()
    private let persistenceController = PersistenceController.shared
    private let iconNames = IconNames()
    
    //MARK: - Bodys
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(iconNames)
                .environmentObject(themeManager)
        }
    }
}
