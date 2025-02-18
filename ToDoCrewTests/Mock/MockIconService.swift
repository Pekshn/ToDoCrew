//
//  MockIconService.swift
//  ToDoCrew
//
//  Created by Petar  on 17.2.25..
//

import XCTest

class MockIconService: IconServiceProtocol {
    
    //MARK: - Properties
    var alternateIconName: String? = nil
    var setIconCalledWith: String? = nil
    var completionError: Error? = nil
    
    //MARK: - Methods
    func setAlternateIconName(_ iconName: String?, completion: @escaping (Error?) -> Void) {
        setIconCalledWith = iconName
        completion(completionError)
    }
}
