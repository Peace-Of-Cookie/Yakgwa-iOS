//
//  AddAppointmentLocationAPI.swift
//
//
//  Created by Kim Dongjoo on 8/5/24.
//

import Network
import Local

public enum AddAppointmentLocationAPI {
    case fetchLocations(String)
}

extension AddAppointmentLocationAPI: YakgwaAPI {
    public var domain: YakgwaDomain {
        switch self {
        case .fetchLocations:
            return .none
        }
    }
    
    public var urlPath: String {
        switch self {
        case .fetchLocations(let query):
            return "/search?q=\(query)"
        }
    }
    
    public var headers: [String : String]? {
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        guard let token = AccessTokenManager.readAccessToken() else { return defaultHeaders }
        
        switch self {
        case .fetchLocations:
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
    
    public var method: Method {
        switch self {
        case .fetchLocations:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .fetchLocations:
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























































