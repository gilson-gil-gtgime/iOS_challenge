//
//  UserInfo.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Mapper

fileprivate let persistedUserKey = "PersistedUserKey"

struct UserInfo: Mappable {
    let _id: String
    let email: String
    let email_verified: Bool
    
    init(map: Mapper) throws {
        try _id = map.from("_id")
        try email = map.from("email")
        try email_verified = map.from("email_verified")
    }
    
    func toJSON() -> [AnyHashable: Any] {
        let json: [AnyHashable: Any] = [
            "_id": _id,
            "email": email,
            "email_verified": email_verified
        ]
        return json
    }
}

// MARK: - Persist
extension UserInfo {
    static var persisted: UserInfo? {
        guard let json = UserDefaults.standard.dictionary(forKey: persistedUserKey) else {
            return nil
        }
        guard let userInfo = UserInfo.from(json as NSDictionary) else {
            return nil
        }
        return userInfo
    }
    
    func persist() {
        UserDefaults.standard.set(toJSON(), forKey: persistedUserKey)
        UserDefaults.standard.synchronize()
    }
}
