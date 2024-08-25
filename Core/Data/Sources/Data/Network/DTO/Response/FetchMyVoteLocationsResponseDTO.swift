//
//  FetchMyVoteLocationsResponseDTO.swift
//
//
//  Created by Ekko on 8/25/24.
//

import Foundation

import Domain

/*
 {
   "time": "2024-08-25T06:39:51.348Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {
     "meetStatus": "CONFIRM",
     "placeInfos": [
       {
         "placeSlotId": 0,
         "title": "string",
         "roadAddress": "string",
         "mapx": "string",
         "mapy": "string"
       }
     ]
   }
 }
 */
public struct FetchMyVoteLocationsResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: ResultDTO
    
    public struct ResultDTO: Decodable {
        let meetStatus: MeetStatus
        let placeInfos: [PlaceInfoDTO]
        
        public struct PlaceInfoDTO: Decodable {
            let placeSlotId: Int
            let title: String
            let roadAddress: String
            let mapx: String
            let mapy: String
        }
        
        enum MeetStatus: String, Decodable {
            case confirm = "CONFIRM"
            case beforeConfirm = "BEFORE_CONFIRM"
            case vote = "VOTE"
            case beforeVote = "BEFORE_VOTE"
        }
    }
}

extension FetchMyVoteLocationsResponseDTO {
    public func toDomain() -> VoteLocationInfo {
        return VoteLocationInfo(
            meetStatus: result.meetStatus.rawValue,
            placeInfos: result.placeInfos.map { $0.toDomain() }
        )
    }
}

extension FetchMyVoteLocationsResponseDTO.ResultDTO.PlaceInfoDTO {
    public func toDomain() -> VoteLocationInfo.PlaceInfo {
        return VoteLocationInfo.PlaceInfo(
            placeSlotId: placeSlotId,
            title: title,
            roadAddress: roadAddress,
            mapx: mapx,
            mapy: mapy
        )
    }
}
