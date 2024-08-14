//
//  CreateAppointmentResponseDTO.swift
//
//
//  Created by Kim Dongjoo on 8/13/24.
//

/*
 {
   "time": "2024-08-13T06:15:33.146Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {
     "meetId": 0
   }
 }
 */
import Domain

public struct CreateAppointmentResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: ResultDTO
    
    struct ResultDTO: Decodable {
        let meetId: Int
    }
}

extension CreateAppointmentResponseDTO {
    func toDomain() -> MeetID {
        return MeetID(result.meetId)
    }
}
