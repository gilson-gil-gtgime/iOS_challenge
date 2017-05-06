//
//  ThemeHelper.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

fileprivate let themeDarkModeKey = "ThemeDarkModeKey"

final class ThemeHelper: NSObject {
    static var darkMode: Bool {
        return UserDefaults.standard.bool(forKey: themeDarkModeKey)
    }
    
    static func setDarkMode(on: Bool) {
        UserDefaults.standard.set(on, forKey: themeDarkModeKey)
        UserDefaults.standard.synchronize()
    }
    
    static var backgroundColor: UIColor {
        if darkMode {
            return .black
        } else {
            return .white
        }
    }
    
    static var foregroundColor: UIColor {
        if darkMode {
            return .white
        } else {
            return .black
        }
    }
}

extension UIColor {
    static var backgroundColor: UIColor {
        return ThemeHelper.backgroundColor
    }
    
    static var foregroundColor: UIColor {
        return ThemeHelper.foregroundColor
    }
}
