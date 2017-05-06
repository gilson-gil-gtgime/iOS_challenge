//
//  UserToken.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Mapper

fileprivate let persistedUserTokenKey = "PersistedUserTokenKey"

struct UserToken: Mappable {
    let access_token: String
    let token_type: String
    
    init(map: Mapper) throws {
        try access_token = map.from("access_token")
        try token_type = map.from("token_type")
    }
    
    func toJSON() -> [AnyHashable: Any] {
        let json: [AnyHashable: Any] = [
            "access_token": access_token,
            "token_type": token_type
        ]
        return json
    }
}

// MARK: - Persist
extension UserToken {
    static var persisted: UserToken? {
        guard let json = UserDefaults.standard.dictionary(forKey: persistedUserTokenKey) else {
            return nil
        }
        guard let userToken = UserToken.from(json as NSDictionary) else {
            return nil
        }
        return userToken
    }
    
    func persist() {
        UserDefaults.standard.set(toJSON(), forKey: persistedUserTokenKey)
        UserDefaults.standard.synchronize()
    }
    
    static func depersist() {
        UserDefaults.standard.removeObject(forKey: persistedUserTokenKey)
        UserDefaults.standard.synchronize()
    }
}
