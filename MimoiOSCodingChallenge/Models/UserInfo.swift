//
//  UserInfo.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Mapper

fileprivate let persistedUserKey = "PersistedUserKey"

final class UserInfoObjC: NSObject {
    private let userInfo: UserInfo
    
    var email: String {
        return userInfo.email
    }
    
    var gravatar: String? {
        guard let gravatar = userInfo.gravatar, gravatar.characters.count > 0 else {
            return nil
        }
        return gravatar
    }
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
    }
    
    static func persistedUserInfo() -> UserInfoObjC? {
        guard let userInfo = UserInfo.persisted else {
            return nil
        }
        let userInfoObjC = UserInfoObjC(userInfo: userInfo)
        return userInfoObjC
    }
}

struct UserInfo: Mappable {
    let _id: String
    let email: String
    let email_verified: Bool
    let gravatar: String?
    
    init(map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? map.optionalFrom("user_id") ?? ""
        try email = map.from("email")
        try email_verified = map.from("email_verified")
        gravatar = map.optionalFrom("picture")
    }
    
    func toJSON() -> [AnyHashable: Any] {
        let json: [AnyHashable: Any] = [
            "_id": _id,
            "email": email,
            "email_verified": email_verified,
            "picture": gravatar ?? ""
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
    
    static func depersist() {
        UserDefaults.standard.removeObject(forKey: persistedUserKey)
        UserDefaults.standard.synchronize()
    }
}
