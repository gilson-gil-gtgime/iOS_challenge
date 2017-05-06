//
//  ProfileService.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Alamofire

final class ProfileService: NSObject {
    static func fetch(token: String,
                      completion: @escaping () -> ()) {
        ProfileURLRequestable(token: token)
            .request { callback in
                do {
                    let response = try callback()
                    guard let json = response.result.value as? NSDictionary else {
                        return
                    }
                    let userInfo = UserInfo.from(json)
                    userInfo?.persist()
                    completion()
                } catch {
                    completion()
                }
        }
    }
}
