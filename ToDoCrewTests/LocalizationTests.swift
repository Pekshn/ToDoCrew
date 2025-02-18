//
//  LocalizationTests.swift
//  ToDoCrew
//
//  Created by Petar  on 17.2.25..
//

import XCTest

class LocalizationTests: XCTestCase {
    
    //MARK: - Testing methods
    func testLocalization_whenAddCorrectKey_returnsLocalizedValue() {
        let localizedText = Localizator.get("Make sure info")
        XCTAssertNotEqual(localizedText, "Make sure info", "Expected translated string, got key instead")
    }
    
    func testLocalization_whenAddIncorrectKey_returnsKey() {
        let missingKey = "non_existent_key"
        let localizedText = Localizator.get(missingKey)
        XCTAssertEqual(localizedText, missingKey, "Should return key when translation is missing")
    }
}
