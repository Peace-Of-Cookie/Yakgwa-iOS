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
    /// 현재 참여중인 약속 목록
    case fetchCurrentAppointments
    /// 모임 참여
    case joinAppointment(JoinAppointmentRequestDTO)
    /// 투표를 위한 모임의 장소후보 정보 조화
    case fetchLocationCandidates(Int)
    /// 투표를 위한 모임의 장소투표후보지 추가
    case addLocationCandidates(Int, AddLocationCandidateRequestDTO)
    /// 모임의 장소 투표
    case voteLocation(Int, VoteLocationRequestDTO)
    /// 모임의 시간 투표
    case voteTime(Int, VoteTimeRequestDTO)
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
        case .fetchCurrentAppointments:
            return .meet
        case .joinAppointment:
            return .meet
        case .fetchLocationCandidates:
            return .meet
        case .addLocationCandidates:
            return .meet
        case .voteTime:
            return .vote
        case .voteLocation:
            return .vote
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
        case .fetchCurrentAppointments:
            return ""
        case .joinAppointment(let dto):
            return "/\(dto.meetId)"
        case .fetchLocationCandidates(let meetId):
            return "/\(meetId)/placeslots"
        case .addLocationCandidates(let meetId, _):
            return "/\(meetId)/placeslots"
        case .voteLocation(let meetId, _):
            return "/\(meetId)/places"
        case .voteTime(let meetId, _):
            return "/\(meetId)/times"
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
        case .joinAppointment:
            return .post
        case .addLocationCandidates:
            return .post
        case .voteTime, .voteLocation:
            return .post
        default:
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
        case .addLocationCandidates(_, let dto):
            return .requestJSONEncodable(dto)
        case .voteLocation(_, let dto):
            return .requestJSONEncodable(dto)
        case .voteTime(_, let dto):
            return .requestJSONEncodable(dto)
        default:
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
