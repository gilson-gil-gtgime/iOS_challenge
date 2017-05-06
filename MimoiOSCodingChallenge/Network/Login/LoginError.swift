//
//  LoginError.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case accountNotFound
    
    var localizedDescription: String {
        switch self {
        case .accountNotFound:
            return String.Authentication.Error.login
        }
    }
}
