//
//  LoginService.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Alamofire

struct LoginService {
    static func login(email: String,
                      password: String,
                      completion: @escaping CompletionHandlerType<Void>) {
        LoginURLRequestable(email: email,
                            password: password)
            .request { callback in
                do {
                    let response = try callback()
                    guard let json = response.result.value as? NSDictionary else {
                        return
                    }
                    let userToken = UserToken.from(json)
                    userToken?.persist()
                    completion { return }
                } catch let error as NetworkError {
                    switch error {
                    case .authFailed:
                        completion { throw LoginError.accountNotFound }
                    }
                } catch {
                    completion { throw error }
                }
        }
    }
}
