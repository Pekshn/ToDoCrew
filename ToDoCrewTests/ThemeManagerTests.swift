//
//  ThemeManagerTests.swift
//  ToDoCrewTests
//
//  Created by Petar  on 14.2.25..
//

import XCTest

final class ThemeManagerTests: XCTestCase {
    
    //MARK: - Properties
    private var userDefaults: UserDefaults!
    private var themeManager: ThemeManager!
    
    //MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: "TestDefaults")
        userDefaults.removePersistentDomain(forName: "TestDefaults")
        themeManager = ThemeManager(storage: userDefaults)
    }
    
    override func tearDown() {
        userDefaults.removePersistentDomain(forName: "TestDefaults")
        userDefaults = nil
        themeManager = nil
        super.tearDown()
    }
    
    //MARK: - Testing methods
    func test_whenThemeIsChanged_shouldLoadSavedTheme() {
        userDefaults.setValue(Theme.blue.rawValue, forKey: Constants.themeKey)
        let newThemeManager = ThemeManager(storage: userDefaults)
        XCTAssertEqual(newThemeManager.current, .blue, "ThemeManager should load the saved theme from UserDefaults.")
    }
    
    func test_whenThemeIsNotChanged_shouldUseDefaultTheme() {
        XCTAssertEqual(themeManager.current, .pink, "ThemeManager should return pink if no theme is saved.")
    }
    
    func test_whenThemeIsUpdated_shouldChangeCurrentTheme() {
        themeManager.updateTheme(.green)
        XCTAssertEqual(themeManager.current, .green, "ThemeManager should update the current theme.")
    }
    
    func test_whenThemeIsChanged_shouldSaveToUserDefaults() {
        themeManager.updateTheme(.green)
        let savedTheme = userDefaults.string(forKey: Constants.themeKey)
        XCTAssertEqual(savedTheme, Theme.green.rawValue, "ThemeManager should save the updated theme to UserDefaults.")
    }
}
