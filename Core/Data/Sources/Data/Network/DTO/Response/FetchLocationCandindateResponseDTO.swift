//
//  FetchLocationCandindateResponseDTO.swift
//
//
//  Created by Ekko on 8/24/24.
//

/*
{
  "time": "2024-08-24T09:50:52.639248739",
  "status": 200,
  "code": "Success",
  "message": "요청에 성공하였습니다.",
  "result": {
    "placeSlotOfMeet": [
      {
        "placeSlotId": 70,
        "placeName": "인천국제공항 제1여객터미널",
        "placeAddress": "인천광역시 중구 운서동 2851",
        "userInfos": []
      },
      {
        "placeSlotId": 71,
        "placeName": "인천국제공항 제2여객터미널",
        "placeAddress": "인천광역시 중구 운서동 2868",
        "userInfos": []
      },
      {
        "placeSlotId": 87,
        "placeName": "스타벅스 강남역점",
        "placeAddress": "도곡동 956 LG전자 강남R&D센터",
        "userInfos": []
      }
    ]
  }
}
*/

/*
 {
   "time": "2024-08-24T00:51:13.685Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {
     "placeSlotOfMeet": [
       {
         "placeSlotId": 0,
         "placeName": "string",
         "placeAddress": "string",
         "userInfos": [
           {
             "username": "string",
             "imageUrl": "string"
           }
         ]
       }
     ]
   }
 }
 */

import Domain

public struct FetchLocationCandindateResponseDTO: Decodable {
    public let time: String
    public let status: Int
    public let code: String
    public let message: String
    public let result: Result
    
    public struct Result: Decodable {
        public let placeSlotOfMeet: [PlaceSlotOfMeet]
        
        public struct PlaceSlotOfMeet: Decodable {
            public let placeSlotId: Int
            public let placeName: String
            public let placeAddress: String
            public let userInfos: [UserInfo]
            
            public struct UserInfo: Decodable {
                public let username: String
                public let imageUrl: String
            }
        }
    }
}

extension FetchLocationCandindateResponseDTO {
    func toDomain() -> [LocationCandidate] {
        return result.placeSlotOfMeet.map {
            LocationCandidate(
                id: "\($0.placeSlotId)",
                title: $0.placeName,
                address: $0.placeAddress,
                userInfo: $0.userInfos.map { Participant(role: nil, imageUrl: $0.imageUrl, name: $0.username) })
        }
    }
}
