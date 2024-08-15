//
//  YakgwaCommonAPI.swift
//
//
//  Created by Kim Dongjoo on 8/12/24.
//

import Network
import Local

public enum YakgwaCommonAPI {
    case createAppointment(CreateAppointmentRequestDTO)
    /// 장소 검색
    case fetchLocations(String)
    /// 장소 상세 정보
    case fetchAppointmentDetail(FetchAppointmentDetailRequestDTO)
}

extension YakgwaCommonAPI: YakgwaAPI {
    public var domain: YakgwaDomain {
        switch self {
        case .createAppointment:
            return .none
        case .fetchLocations:
            return .none
        case .fetchAppointmentDetail:
            return .meet
        }
    }
    
    public var urlPath: String {
        switch self {
        case .createAppointment:
            return "/meets"
        case .fetchLocations:
            return "/search"
        case .fetchAppointmentDetail(let dto):
            return "/\(dto.meetId)"
        }
    }
    
    public var headers: [String : String]? {
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        guard let token = AccessTokenManager.readAccessToken() else { return defaultHeaders }
        
        switch self {
        default:
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
    
    public var method: Method {
        switch self {
        case .createAppointment:
            return .post
        case .fetchLocations:
            return .get
        case .fetchAppointmentDetail:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .createAppointment(let dto):
            return .requestJSONEncodable(dto)
        case .fetchLocations(let query):
            return .requestParameters(parameters: ["search": query], encoding: URLEncoding.queryString)
        case .fetchAppointmentDetail(let dto):
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
