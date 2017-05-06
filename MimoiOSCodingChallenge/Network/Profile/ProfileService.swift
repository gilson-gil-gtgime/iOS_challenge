//
//  ProfileService.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Alamofire

final class ProfileService: NSObject {
    static func fetch(access_token: String,
                      token_type: String,
                      completion: @escaping () -> ()) {
        ProfileURLRequestable(access_token: access_token,
                              token_type: token_type)
            .request { callback in
                do {
                    let response = try callback()
                    guard let json = response.result.value as? NSDictionary else {
                        return
                    }
                    let userToken = UserToken.from(json)
                    userToken?.persist()
                    completion()
                } catch {
                    completion()
                }
        }
    }
}
