//
//  SelectAppointmentThemeAPI.swift
//
//
//  Created by Kim Dongjoo on 8/1/24.
//

import Network
import Local

public enum SelectAppointmentThemeAPI {
    case fetchThemes
}

extension SelectAppointmentThemeAPI: YakgwaAPI {
    public var domain: YakgwaDomain {
        switch self {
        case .fetchThemes:
            return .none
        }
    }
    
    public var urlPath: String {
        switch self {
        case .fetchThemes:
            return "/theme"
        }
    }
    
    public var headers: [String : String]? {
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        guard let token = AccessTokenManager.readAccessToken() else { return defaultHeaders }
        
        switch self {
        case .fetchThemes:
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
    
    public var method: Method {
        switch self {
        case .fetchThemes:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .fetchThemes:
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
