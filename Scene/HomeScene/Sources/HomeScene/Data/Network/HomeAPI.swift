//
//  HomeAPI.swift
//
//
//  Created by Ekko on 7/24/24.
//

import Network
import Local

public enum HomeAPI {
    case fetchAppointments
}

extension HomeAPI: YakgwaAPI {
    public var domain: YakgwaDomain {
        switch self {
        case .fetchAppointments:
            return .meet
        }
    }
    
    public var urlPath: String {
        switch self {
        case .fetchAppointments:
            return ""
        }
    }
    
    public var headers: [String : String]? {
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        guard let token = AccessTokenManager.readAccessToken() else { return defaultHeaders }
        
        switch self {
        case .fetchAppointments:
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
    
    public var method: Method {
        switch self {
        case .fetchAppointments:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .fetchAppointments:
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
