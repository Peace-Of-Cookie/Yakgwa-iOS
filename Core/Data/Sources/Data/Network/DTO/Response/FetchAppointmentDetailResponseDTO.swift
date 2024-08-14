//
//  FetchAppointmentDetailResponseDTO.swift
//
//
//  Created by Ekko on 8/15/24.
//

/*
 {
   "time": "2024-08-14T17:14:05.634Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {
     "meetInfo": {
       "themeName": "데이트",
       "meetTitle": "다음 세션 모임",
       "description": "설명"
     },
     "participantInfo": [
       {
         "meetRole": "LEADER(약과장) 또는 PARTICIPANT(약과원)",
         "imageUrl": "string",
         "name": "string"
       }
     ]
   }
 }
 */
import Domain

public struct FetchAppointmentDetailResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: ResultDTO
    
    struct ResultDTO: Decodable {
        let meetInfo: MeetInfoDTO
        let participantInfo: [ParticipantInfoDTO]
        
        struct MeetInfoDTO: Decodable {
            let themeName: String
            let meetTitle: String
            let description: String
        }
        
        struct ParticipantInfoDTO: Decodable {
            let meetRole: String
            let imageUrl: String
            let name: String
        }
    }
}

extension FetchAppointmentDetailResponseDTO {
    func toDomain() -> AppointmentDetail {
        return AppointmentDetail(
            title: result.meetInfo.meetTitle,
            description: result.meetInfo.description,
            themeName: result.meetInfo.themeName,
            participants: result.participantInfo.map {
                Participant(role: $0.meetRole, imageUrl: $0.imageUrl, name: $0.name)
            }
        )
    }
}

