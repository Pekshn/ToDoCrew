//
//  ContentViewPage.swift
//  ToDoCrew
//
//  Created by Petar  on 18.2.25..
//

import Foundation
import XCTest

class ContentViewPage {
    
    //MARK: - Properties
    private var app: XCUIApplication
    
    var taskList: XCUIElement {
        app.collectionViews["taskList"]
    }
    
    var addTodoButton: XCUIElement {
        app.buttons["addTodoButton"]
    }
    
    //MARK: - Init
    init(app: XCUIApplication) {
        self.app = app
    }
}
