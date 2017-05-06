//
//  SessionHelper.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

final class SessionHelper: NSObject {
    static var isLoggedIn: Bool {
        return currentUserInfo != nil
    }
    
    static var currentUserInfo: UserInfo? {
        guard let userInfo = UserInfo.persisted else {
            return nil
        }
        return userInfo
    }
    
    static var currentUserToken: UserToken? {
        guard let userToken = UserToken.persisted else {
            return nil
        }
        return userToken
    }
    
    static var currentAccessToken: String? {
        guard let userToken = currentUserToken else {
            return nil
        }
        return "\(userToken.token_type.capitalized) \(userToken.access_token)"
    }
    
    static func removeSession() {
        UserInfo.depersist()
        UserToken.depersist()
    }
}
