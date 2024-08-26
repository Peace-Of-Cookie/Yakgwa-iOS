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
