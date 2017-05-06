//
//  String+helper.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

extension String {
    func noSpacingString() -> String {
        let string = replacingOccurrences(of: " ", with: "")
        return string
    }
}
