//
//  AddTodoViewPage.swift
//  ToDoCrew
//
//  Created by Petar  on 18.2.25..
//

import Foundation
import XCTest

class AddTodoViewPage {
    
    //MARK: - Properties
    private var app: XCUIApplication
    
    var todoTitleField: XCUIElement {
        app.textFields["todoTitleField"]
    }
    
    var saveTodoButton: XCUIElement {
        app.buttons["saveTodoButton"]
    }
    
    //MARK: - Init
    init(app: XCUIApplication) {
        self.app = app
    }
}
