//
//  TodoViewModel.swift
//  ToDoCrew
//
//  Created by Petar  on 13.2.25..
//

import Foundation
import CoreData
import SwiftUI

class TodoViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var todos: [Todo] = []
    private let context: NSManagedObjectContext
    let priorities = [Localization.low, Localization.medium, Localization.high]
    private(set) var errorTitle = ""
    private(set) var errorMessage = ""
    
    //MARK: - Init
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        fetchTodos()
    }
}

//MARK: - Public API
extension TodoViewModel {
    
    func colorize(priority: String) -> Color {
        switch priority {
        case Localization.low: return .green
        case Localization.medium: return .yellow
        case Localization.high: return .pink
        default: return .gray
        }
    }
    
    func isValidTodo(name: String) -> Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorTitle = Localization.invalidName
            errorMessage = Localization.makeSureInfo
            return false
        }
        return true
    }
    
    //MARK: - CRUD methods
    func fetchTodos() {
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]
        do {
            todos = try context.fetch(request)
        } catch {
            print("Failed to fetch todos: \(error.localizedDescription)")
        }
    }
    
    func deleteTodo(at offsets: IndexSet) {
        offsets.forEach { index in
            let todo = todos[index]
            context.delete(todo)
        }
        saveContext()
    }
    
    func addTodo(name: String, priority: String) {
        let newTodo = Todo(context: context)
        newTodo.name = name
        newTodo.priority = priority
        saveContext()
    }
}

//MARK: - Private API
extension TodoViewModel {
    
    //MARK: - CRUD method
    private func saveContext() {
        do {
            try context.save()
            fetchTodos()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}
