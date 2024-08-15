//
//  File.swift
//  
//
//  Created by Ekko on 8/15/24.
//

/*
 {
   "time": "2024-08-15T10:49:11.620Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {
     "meetInfosWithStatus": [
       {
         "meetStatus": "CONFIRM",
         "meetInfo": {
           "meetThemeName": "데이트",
           "meetDateTime": "2024-08-15T10:49:11.620Z",
           "placeName": "스타벅스",
           "meetTitle": "다음 세션 모임",
           "meetId": 1,
           "description": "설명"
         }
       }
     ]
   }
 }
 */
import Domain

public struct FetchCurrentAppointmentsResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: ResultDTO
    
    struct ResultDTO: Decodable {
        let meetInfosWithStatus: [MeetInfoWithStatusDTO]
        
        struct MeetInfoWithStatusDTO: Decodable {
            let meetStatus: String
            let meetInfo: MeetInfoDTO
            
            struct MeetInfoDTO: Decodable {
                let meetThemeName: String
                let meetDateTime: String
                let placeName: String
                let meetTitle: String
                let meetId: Int
                let description: String
            }
        }
    }
}

extension FetchCurrentAppointmentsResponseDTO {
    func toDomain() {
        
    }
}
