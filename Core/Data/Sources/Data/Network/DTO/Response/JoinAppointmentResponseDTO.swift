//
//  JoinAppointmentResponseDTO.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
//

/*
 {
   "time": "2024-08-23T11:26:50.442Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {
     "participantId": 0
   }
 }
 */

import Foundation

import Domain

public struct JoinAppointmentResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: ResultDTO
    
    struct ResultDTO: Decodable {
        let participantId: Int
    }
}
