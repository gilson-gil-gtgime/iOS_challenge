//
//  LoginURLRequestable.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Alamofire

struct LoginURLRequestable: URLRequestableProtocol {
    let email: String
    let password: String
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "oauth/ro"
    }
    
    var parameters: Parameters? {
        return ["username": email,
                "password": password,
                "grant_type": "password",
                "scope": "openid"]
    }
    
    var headers: Parameters? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
