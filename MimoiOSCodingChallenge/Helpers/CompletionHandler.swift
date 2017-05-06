//
//  CompletionHandler.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

typealias CompletionHandlerType<T> = (() throws -> T) -> Void
