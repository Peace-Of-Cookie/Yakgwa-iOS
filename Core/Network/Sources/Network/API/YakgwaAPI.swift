//
//  YakgwaAPI.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import Foundation

import Moya

public protocol YakgwaAPI: TargetType {
    var domain: YakgwaDomain { get }
    var urlPath: String { get }
    var errorMap: [Int: NetworkError] { get }
}

extension YakgwaAPI {
    public var baseURL: URL {
        return URL(string: "http://yakgwa.site/api/v1")!
    }
    
    public var path: String {
        domain.asURLString + urlPath
    }
    
    var headers: [String: String]? {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

/// API Domain
public enum YakgwaDomain: String {
    case login
    case vote
    case user
    case none
}

extension YakgwaDomain {
    var asURLString: String {
        "\(self.path)"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth"
        case .vote:
            return "/vote"
        case .user:
            return "/users"
        case .none:
            return ""
        }
    }
}

