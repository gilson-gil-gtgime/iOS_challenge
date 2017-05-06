//
//  String+mimoiOSCC.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

extension String {
    static let warning = NSLocalizedString("WARNING", comment: "")
    static let ok = NSLocalizedString("OK", comment: "")
    
    struct Authentication {
        struct Placeholder {
            static let email = NSLocalizedString("AUTHENTICATION_PLACEHOLDER_EMAIL", comment: "")
            static let password = NSLocalizedString("AUTHENTICATION_PLACEHOLDER_PASSWORD", comment: "")
        }
        struct ButtonTitle {
            static let login = NSLocalizedString("AUTHENTICATION_BUTTONTITLE_LOGIN", comment: "")
            static let signup = NSLocalizedString("AUTHENTICATION_BUTTONTITLE_SIGNUP", comment: "")
        }
        struct Error {
            static let login = NSLocalizedString("AUTHENTICATION_ERROR_LOGIN", comment: "")
            static let signup = NSLocalizedString("AUTHENTICATION_ERROR_SIGNUP", comment: "")
        }
    }
}
