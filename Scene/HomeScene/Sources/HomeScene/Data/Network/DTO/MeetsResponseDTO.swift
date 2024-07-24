//
//  MeetResponseDTO.swift
//
//
//  Created by Ekko on 7/24/24.
//
/*
{
  "time": "2024-07-24T06:13:07.313Z",
  "status": 0,
  "code": "string",
  "message": "string",
  "result": {
    "meetInfosWithStatus": [
      {
        "meetStatus": "CONFIRM",
        "meetInfo": {
          "meetThemeName": "데이트",
          "meetDateTime": "2024-07-24T06:13:07.313Z",
          "placeName": "스타벅스",
          "meetTitle": "다음 세션 모임",
          "meetId": 1
        }
      }
    ]
  }
}
 */
import Foundation

public struct MeetResponseDTO: Codable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: MeetResultDTO
    
    struct MeetResultDTO: Codable {
        let meetInfosWithStatus: [MeetInfoWithStatusDTO]
        
        struct MeetInfoWithStatusDTO: Codable {
            let meetStatus: String
            let meetInfo: MeetInfoDTO
            
            struct MeetInfoDTO: Codable {
                let meetThemeName: String
                let meetDateTime: String
                let placeName: String
                let meetTitle: String
                let meetId: Int
            }
        }
    }
}

extension MeetResponseDTO {
    /// MeetResponseDTO -> [Appointment]([Entity])
    func toDomain() -> [Appointment] {
        return result.meetInfosWithStatus.map { $0.toDomain() }
    }
}

extension MeetResponseDTO.MeetResultDTO.MeetInfoWithStatusDTO {
    func toDomain() -> Appointment {
        return Appointment(
            status: meetStatus,
            theme: meetInfo.meetThemeName,
            dateTime: meetInfo.meetDateTime,
            location: meetInfo.placeName,
            title: meetInfo.meetTitle,
            id: meetInfo.meetId
        )
    }
}
