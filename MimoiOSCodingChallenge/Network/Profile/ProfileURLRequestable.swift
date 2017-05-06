//
//  ProfileURLRequestable.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Alamofire

struct ProfileURLRequestable: URLRequestableProtocol {
    let access_token: String
    let token_type: String
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "userinfo"
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: Parameters? {
        return [
            "Authorization": "\(token_type) \(access_token)"
        ]
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
