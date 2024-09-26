//
//  FetchDateCandidateResponseDTO.swift
//
//
//  Created by Ekko on 8/26/24.
//

/*
 {
   "time": "2024-08-26T12:01:47.278Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {
     "meetStatus": "CONFIRM",
     "timeInfos": [
       {
         "timeId": 0,
         "voteTime": "2024-08-26T12:01:47.278Z"
       }
     ],
     "voteDate": {
       "startVoteDate": "2024-07-13",
       "endVoteDate": "2024-07-13"
     }
   }
 }
 */

import Foundation

import Domain

public struct FetchDateCandidateResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: Result

    public struct Result: Decodable {
        let meetStatus: MeetStatus
        let timeInfos: [TimeInfo]?
        let voteDate: VoteDate?

        public struct TimeInfo: Decodable {
            let timeId: Int?
            let voteTime: String?
        }

        public struct VoteDate: Decodable {
            let startVoteDate: String
            let endVoteDate: String
        }
    }
}

extension FetchDateCandidateResponseDTO {
    func toDomain() -> VoteDateInfo {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return VoteDateInfo(
            meetStatus: result.meetStatus,
            timeInfo: result.timeInfos?.map { $0.toDomain() },
            startVoteDate: dateFormatter.date(from: result.voteDate?.startVoteDate ?? ""),
            endVoteDate: dateFormatter.date(from: result.voteDate?.endVoteDate ?? "")
        )
    }
}

extension FetchDateCandidateResponseDTO.Result.TimeInfo {
    func toDomain() -> VoteDateInfo.TimeInfo {        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul") // 한국 시간대를 사용
        dateFormatter.locale = Locale(identifier: "ko_KR") // 한국어로 지역화
        
        let date = dateFormatter.date(from: voteTime ?? "")
        return VoteDateInfo.TimeInfo(
            timeId: timeId,
            voteTime: date
        )
    }
}
