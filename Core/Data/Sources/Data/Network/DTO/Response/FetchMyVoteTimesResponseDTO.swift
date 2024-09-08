//
//  FetchMyVoteTimesResponseDTO.swift
//
//
//  Created by Ekko on 8/25/24.
//

/*
 {
   "time": "2024-08-25T06:25:55.780Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {
     "meetStatus": "CONFIRM",
     "timeInfos": [
       {
         "timeId": 0,
         "voteTime": "2024-08-25T06:25:55.780Z"
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

public struct FetchMyVoteTimesResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: Result
    
    public struct Result: Decodable {
        let meetStatus: String
        let timeInfos: [TimeInfo]
        let voteDate: VoteDate
        
        public struct TimeInfo: Decodable {
            let timeId: Int
            let voteTime: String
        }
        
        public struct VoteDate: Decodable {
            let startVoteDate: String
            let endVoteDate: String
        }
    }
}
