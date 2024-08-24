//
//  VoteLocationResponseDTO.swift
//
//
//  Created by Ekko on 8/24/24.
//

/*
 {
   "time": "2024-08-24T02:15:34.913Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {}
 }
 */

import Foundation

import Domain

public struct VoteLocationResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
}
