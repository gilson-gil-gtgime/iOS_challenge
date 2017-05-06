//
//  URLRequestable.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Alamofire

struct NetworkConstants {
    fileprivate static let baseURLString = "https://mimo-test.auth0.com/"
    fileprivate static let auth0ClientID = "PAn11swGbMAVXVDbSCpnITx5Utsxz1co"
    fileprivate static let auth0ConnectionName = "Username-Password-Authentication"
    fileprivate static let contentType = "application/json"
}

protocol URLRequestableProtocol: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var contentType: String { get }
    
    func asURLRequest() throws -> URLRequest
    
    func request(completion: @escaping CompletionHandlerType<DataResponse<Any>>)
}

extension URLRequestableProtocol {
    var contentType: String {
        return NetworkConstants.contentType
    }
    
    func asURLRequest() throws -> URLRequest {
        do {
            let url = try NetworkConstants.baseURLString.asURL().appendingPathComponent(path)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            urlRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
            headers?.forEach {
                if let value = $0.value as? String {
                    urlRequest.addValue(value, forHTTPHeaderField: $0.key)
                }
            }
            var parameters = self.parameters ?? [:]
            parameters["client_id"] = NetworkConstants.auth0ClientID
            parameters["connection"] = NetworkConstants.auth0ConnectionName
            return try encoding.encode(urlRequest, with: parameters)
        } catch {
            throw error
        }
    }
    
    func request(completion: @escaping CompletionHandlerType<DataResponse<Any>>) {
        Alamofire.request(self)
            .responseJSON { response in
                if let httpResponse = response.response, httpResponse.statusCode == 401 {
                    completion { throw NetworkError.authFailed }
                } else if let error = response.result.error {
                    completion { throw error }
                } else {
                    completion { return response }
                }
        }
    }
}
