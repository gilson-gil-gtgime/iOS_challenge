//
//  SignUpURLRequestable.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Alamofire

struct SignUpURLRequestable: URLRequestableProtocol {
    let email: String
    let password: String
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "dbconnections/signup"
    }
    
    var parameters: Parameters? {
        return ["email": email,
                "password": password]
    }
    
    var headers: Parameters? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
