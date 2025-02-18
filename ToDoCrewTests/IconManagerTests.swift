//
//  IconManagerTests.swift
//  ToDoCrew
//
//  Created by Petar  on 17.2.25..
//

import XCTest

class IconManagerTests: XCTestCase {
    
    //MARK: - Properties
    var userDefaults: UserDefaults!
    var mockIconService: MockIconService!
    var iconManager: IconManager!
    
    //MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: "TestDefaults")
        userDefaults.removePersistentDomain(forName: "TestDefaults")
        mockIconService = MockIconService()
        iconManager = IconManager(userDefaults: userDefaults, appIconService: mockIconService)
    }
    
    override func tearDown() {
        userDefaults.removePersistentDomain(forName: "TestDefaults")
        userDefaults = nil
        mockIconService = nil
        iconManager = nil
        super.tearDown()
    }
    
    //MARK: - Testing methods
    func test_IconManager_Initialization() {
        XCTAssertEqual(iconManager.currentIndex, 0, "Default icon index should be 0")
        XCTAssertFalse(iconManager.iconNames.isEmpty, "There should be at least the default icon")
    }
    
    func test_UpdateAppIcon_Success() {
        let newIconName = "NewIcon"
        iconManager.iconNames.append(newIconName)
        let newAppIndex = iconManager.iconNames.lastIndex(where: { $0 == newIconName })!
        iconManager.updateAppIcon(to: newAppIndex)
        
        let expectation = expectation(description: "App icon should update asynchronously")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertEqual(self?.mockIconService.setIconCalledWith, newIconName, "Icon name should be updated")
            XCTAssertEqual(self?.iconManager.currentIndex, newAppIndex, "Current index should be updated")
            XCTAssertEqual(self?.userDefaults.string(forKey: Constants.iconKey), newIconName, "UserDefaults should store the new icon name")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_UpdateAppIcon_Failure() {
        let newIconName = "NewIcon"
        iconManager.iconNames.append(newIconName)
        let newAppIndex = iconManager.iconNames.lastIndex(where: { $0 == newIconName })!
        mockIconService.completionError = NSError(domain: "TestError", code: 1, userInfo: nil)
        iconManager.updateAppIcon(to: newAppIndex)
        
        let expectation = expectation(description: "App icon should update asynchronously")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertEqual(self?.mockIconService.setIconCalledWith, newIconName, "On failure, the icon name should be passed")
            XCTAssertNotEqual(self?.iconManager.currentIndex, newAppIndex, "Index should not change on failure")
            XCTAssertNil(self?.userDefaults.string(forKey: Constants.iconKey), "UserDefaults should not update on failure")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
