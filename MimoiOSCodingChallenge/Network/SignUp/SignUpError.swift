//
//  SignUpError.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

enum SignUpError: Error {
    case accountFound
    
    var localizedDescription: String {
        switch self {
        case .accountFound:
            return String.Authentication.Error.signup
        }
    }
    
    init?(code: String?) {
        guard let code = code else {
            return nil
        }
        guard code == "user_exists" else {
            return nil
        }
        self = .accountFound
    }
}
