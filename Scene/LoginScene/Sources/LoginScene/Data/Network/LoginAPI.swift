//
//  LoginAPI.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import Foundation

import Network

public enum LoginAPI {
    case login(token: String, body: Data)
    case logout(token: String)
    case reissue(token: String)
}

extension LoginAPI: YakgwaAPI {
    public var domain: YakgwaDomain {
        switch self {
        case .login, .logout, .reissue:
            return .login
        }
    }
    
    public var urlPath: String {
        switch self {
        case .login:
            return "/login"
        case .logout:
            return "/logout"
        case .reissue:
            return "/reissue"
        }
    }
    
    public var headers: [String: String]? {
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        switch self {
        case let .login(token, _), let .logout(token), let .reissue(token):
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .logout:
            return .post
        case .reissue:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .login(_, body):
            return .requestData(body)
        case .logout:
            return .requestPlain
        case .reissue:
            return .requestPlain
        }
    }
    
    public var errorMap: [Int: NetworkError] {
        [
            400: .badRequest,
            401: .tokenExpired,
            403: .notFound,
            404: .tooManyRequest,
            500: .internalServerError
        ]
    }
}
