//
//  Springboard.swift
//  ToDoCrew
//
//  Created by Petar  on 18.2.25..
//

import XCTest

class Springboard {
    
    //MARK: - Properties
    static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    //MARK: - Methods
    class func deleteApp() {
        XCUIApplication().terminate()
        springboard.activate()
        if springboard.icons.matching(identifier: "ToDoCrew").firstMatch.exists {
            let appIcon = springboard.icons.matching(identifier: "ToDoCrew").firstMatch
            appIcon.press(forDuration: 1.3)
            let _ = springboard.alerts.buttons["Remove App"].waitForExistence(timeout: 1)
            springboard.buttons["Remove App"].tap()
            
            let deleteAppButton = springboard.alerts.buttons["Delete App"].firstMatch
            if deleteAppButton.waitForExistence(timeout: 2) {
                deleteAppButton.tap()
                let secondDeleteButton = springboard.alerts.buttons["Delete"].firstMatch
                if secondDeleteButton.waitForExistence(timeout: 2) {
                    secondDeleteButton.tap()
                }
            }
        }
    }
}
