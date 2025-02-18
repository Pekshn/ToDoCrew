//
//  ToDoCrewUITests.swift
//  ToDoCrewUITests
//
//  Created by Petar  on 14.2.25..
//

import XCTest

final class ToDoCrewUITests: XCTestCase {
    
    //MARK: - Properties
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!
    private var addTodoViewPage: AddTodoViewPage!
    
    //MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        Springboard.deleteApp()
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        addTodoViewPage = AddTodoViewPage(app: app)
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        contentViewPage = nil
        addTodoViewPage = nil
        Springboard.deleteApp()
        super.tearDown()
    }
    
    //MARK: - Testing methods
    func test_whenAppIsFirstTimeLaunched_shouldNotDisplayAnyTasks() {
        XCTAssertEqual(0, contentViewPage.taskList.cells.count)
    }
    
    func test_whenUserSavesFirstTask_shouldDisplayTaskSuccessfully() {
        contentViewPage.addTodoButton.tap()
        let _ = addTodoViewPage.todoTitleField.waitForExistence(timeout: 1)
        addTodoViewPage.todoTitleField.tap()
        addTodoViewPage.todoTitleField.typeText("First Task")
        addTodoViewPage.saveTodoButton.tap()
        XCTAssertEqual(1, contentViewPage.taskList.cells.count)
    }
    
    func test_whenUserSavesTaskWithChangedPriority_shouldDisplayTaskSuccessfully() {
        contentViewPage.addTodoButton.tap()
        let _ = addTodoViewPage.todoTitleField.waitForExistence(timeout: 1)
        addTodoViewPage.todoTitleField.tap()
        addTodoViewPage.todoTitleField.typeText("First Task")
        addTodoViewPage.saveTodoButton.tap()
        XCTAssertEqual(1, contentViewPage.taskList.cells.count)
    }
    
    func test_whenUserDeletesTask_shoulDeleteTaskSuccessfully() {
        contentViewPage.addTodoButton.tap()
        let _ = addTodoViewPage.todoTitleField.waitForExistence(timeout: 1)
        addTodoViewPage.todoTitleField.tap()
        addTodoViewPage.todoTitleField.typeText("Task To Delete")
        addTodoViewPage.saveTodoButton.tap()
        let cell = contentViewPage.taskList.cells.firstMatch
        XCTAssertTrue(cell.staticTexts["Task To Delete"].exists)
        cell.swipeLeft()
        contentViewPage.taskList.buttons["Delete"].tap()
        XCTAssertFalse(cell.exists)
    }
}
