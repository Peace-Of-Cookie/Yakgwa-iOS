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
    public let time: String
    public let status: Int
    public let code: String
    public let message: String
    public let result: Result

    public struct Result: Decodable {
        public let meetStatus: String
        public let timeInfos: [TimeInfo]?
        public let voteDate: VoteDate?

        public struct TimeInfo: Decodable {
            public let timeId: Int?
            public let voteTime: String?
        }

        public struct VoteDate: Decodable {
            public let startVoteDate: String?
            public let endVoteDate: String?
        }
    }
}

extension FetchDateCandidateResponseDTO {
    func toDomain() -> VoteDateInfo {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
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
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: voteTime ?? "") ?? Date()
            
            return VoteDateInfo.TimeInfo(
                timeId: timeId,
                voteTime: date
            )
        }
}
