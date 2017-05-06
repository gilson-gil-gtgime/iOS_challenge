//
//  String+mimoiOSCC.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

extension String {
    struct Authentication {
        struct Placeholder {
            static let email = NSLocalizedString("AUTHENTICATION_PLACEHOLDER_EMAIL", comment: "")
            static let password = NSLocalizedString("AUTHENTICATION_PLACEHOLDER_PASSWORD", comment: "")
        }
        struct ButtonTitle {
            static let login = NSLocalizedString("AUTHENTICATION_BUTTONTITLE_LOGIN", comment: "")
            static let signup = NSLocalizedString("AUTHENTICATION_BUTTONTITLE_SIGNUP", comment: "")
        }
    }
}
