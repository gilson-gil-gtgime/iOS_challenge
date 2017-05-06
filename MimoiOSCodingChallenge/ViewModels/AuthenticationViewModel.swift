//
//  AuthenticationViewModel.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

struct AuthenticationViewModel {
    func login(email: String?, password: String?, completion: @escaping CompletionHandlerType<Void>) {
        guard let email = validate(text: email), let password = validate(text: password) else {
            completion { throw MimoError.incompleteFields }
            return
        }
        LoginService.login(email: email, password: password, completion: completion)
    }
    
    func signup(email: String?, password: String?, completion: @escaping CompletionHandlerType<Void>) {
        guard let email = validate(text: email), let password = validate(text: password) else {
            completion { throw MimoError.incompleteFields }
            return
        }
        SignUpService.signUp(email: email, password: password, completion: completion)
    }
}

fileprivate extension AuthenticationViewModel {
    func validate(text: String?) -> String? {
        guard let text = text, text.characters.count > 0 else {
            return nil
        }
        return text
    }
}
