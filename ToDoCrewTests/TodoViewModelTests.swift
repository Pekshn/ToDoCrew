//
//  TodoViewModelTests.swift
//  ToDoCrew
//
//  Created by Petar  on 18.2.25..
//

import XCTest
import SwiftUI
import CoreData
@testable import ToDoCrew

class TodoViewModelTests: XCTestCase {
    
    //MARK: - Properties
    var viewModel: TodoViewModel!
    var mockContext: NSManagedObjectContext!
    
    //MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        let container = NSPersistentContainer(name: "ToDoCrew")
        let description = container.persistentStoreDescriptions.first
        description?.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { (storeDescription, error) in
            XCTAssertNil(error, "Neuspešno učitavanje persistent store-a: \(error?.localizedDescription ?? "Nepoznata greška")")
        }
        mockContext = container.viewContext
        viewModel = TodoViewModel(context: mockContext)
    }
    
    override func tearDown() {
        viewModel = nil
        mockContext = nil
        super.tearDown()
    }
    
    //MARK: - Testing methods
    func test_whenFirstTaskIsAdded_shouldContainThatTask() {
        viewModel.addTodo(name: "Test Task", priority: Localization.high)
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        let results = try? mockContext.fetch(fetchRequest)
        XCTAssertEqual(results?.count, 1)
        XCTAssertEqual(results?.first?.name, "Test Task")
        XCTAssertEqual(results?.first?.priority, Localization.high)
    }
    
    func test_whenOneAndOnlyTaskIsDeleted_shouldNotHaveMoreTasks() {
        viewModel.addTodo(name: "Task to Delete", priority: Localization.medium)
        viewModel.fetchTodos()
        XCTAssertEqual(viewModel.todos.count, 1)
        viewModel.deleteTodo(at: IndexSet(arrayLiteral: 0))
        viewModel.fetchTodos()
        XCTAssertEqual(viewModel.todos.count, 0)
    }
    
    func test_whenEmptyNameTaskIsSubmitted_shouldConfigureErrorTitleAndMessage() {
        XCTAssertFalse(viewModel.isValidTodo(name: ""))
        XCTAssertEqual(viewModel.errorTitle, Localization.invalidName)
        XCTAssertEqual(viewModel.errorMessage, Localization.makeSureInfo)
    }
    
    func test_whenCorrectNameTaskIsSubmitted_shouldReturnValidationTrue() {
        XCTAssertTrue(viewModel.isValidTodo(name: "Valid Task"))
    }
    
    func test_whenColorizingTasks_shouldReturnCorrectColorsByPriorities() {
        XCTAssertEqual(viewModel.colorize(priority: Localization.low), Color.green)
        XCTAssertEqual(viewModel.colorize(priority: Localization.medium), Color.yellow)
        XCTAssertEqual(viewModel.colorize(priority: Localization.high), Color.pink)
        XCTAssertEqual(viewModel.colorize(priority: "Unknown"), Color.gray)
    }
}
