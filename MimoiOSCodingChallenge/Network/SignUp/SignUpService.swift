//
//  SignUpService.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Alamofire

struct SignUpService {
    static func signUp(email: String,
                       password: String,
                       completion: @escaping CompletionHandlerType<Void>) {
        SignUpURLRequestable(email: email,
                             password: password)
            .request { callback in
                do {
                    let response = try callback()
                    guard let json = response.result.value as? NSDictionary else {
                        return
                    }
                    if let signupError = SignUpError(code: json["code"] as? String) {
                        completion { throw signupError }
                        return
                    }
                    let user = UserInfo.from(json)
                    user?.persist()
                    LoginService.login(email: email,
                                       password: password) { callback in
                                        do {
                                            try callback()
                                            completion { return }
                                        } catch {
                                            completion { throw error }
                                        }
                    }
                } catch {
                    completion { throw error }
                }
        }
    }
}
