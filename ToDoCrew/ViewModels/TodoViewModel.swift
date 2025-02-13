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
    let priorities = ["Low", "Medium", "High"]
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
        case "Low": return .green
        case "Medium": return .yellow
        case "High": return .pink
        default: return .gray
        }
    }
    
    func isValidTodo(name: String) -> Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorTitle = "Invalid name"
            errorMessage = "Make sure to enter something for the new todo item."
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
