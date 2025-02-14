//
//  Localization.swift
//  ToDoCrew
//
//  Created by Petar  on 14.2.25..
//

import Foundation

struct Localization {
    
    //MARK: - Properties
    static var todoCrew: String { Localizator.get("TodoCrew") }
    static var pinkTheme: String { Localizator.get("Pink theme") }
    static var blueTheme: String { Localizator.get("Blue theme") }
    static var greenTheme: String { Localizator.get("Green theme") }
    static var todo: String { Localizator.get("Todo") }
    static var priority: String { Localizator.get("Priority") }
    static var save: String { Localizator.get("Save") }
    static var newTodo: String { Localizator.get("New Todo") }
    static var oK: String { Localizator.get("OK") }
    static var unknown: String { Localizator.get("Unknown") }
    static var chooseIcon: String { Localizator.get("Choose the App icon") }
    static var appIcon: String { Localizator.get("AppIcon") }
    static var chooseTheme: String { Localizator.get("Choose the app theme") }
    static var followUs: String { Localizator.get("Follow us on social media") }
    static var website: String { Localizator.get("Website") }
    static var twitter: String { Localizator.get("Twitter") }
    static var courses: String { Localizator.get("Courses") }
    static var aboutTheApp: String { Localizator.get("About the application") }
    static var application: String { Localizator.get("Application") }
    static var compatibility: String { Localizator.get("Compatibility") }
    static var developer: String { Localizator.get("Developer") }
    static var thanksTo: String { Localizator.get("Thanks to") }
    static var version: String { Localizator.get("Version") }
    static var copyrightInfo: String { Localizator.get("Copyright info") }
    static var settings: String { Localizator.get("Settings") }
    static var iPhoneIPad: String { Localizator.get("iPhone, iPad") }
    static var low: String { Localizator.get("Low") }
    static var medium: String { Localizator.get("Medium") }
    static var high: String { Localizator.get("High") }
    static var invalidName: String { Localizator.get("Invalid name") }
    static var makeSureInfo: String { Localizator.get("Make sure info") }
    static var developerValue: String { Localizator.get("DeveloperValue") }
    static var thanksToValue: String { Localizator.get("ThanksToValue") }
    static var versionValue: String { Localizator.get("VersionValue") }
    static var tip1: String { Localizator.get("Use your time wisely.") }
    static var tip2: String { Localizator.get("Slow and steady wins the race.") }
    static var tip3: String { Localizator.get("Keep it short and sweet.") }
    static var tip4: String { Localizator.get("Put hard tasks first.") }
    static var tip5: String { Localizator.get("Reward your self after work.") }
    static var tip6: String { Localizator.get("Collect tasks ahead of time") }
    static var tip7: String { Localizator.get("Each night schedule for tomorrow.") }
}

final class Localizator {
    
    static func get(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
