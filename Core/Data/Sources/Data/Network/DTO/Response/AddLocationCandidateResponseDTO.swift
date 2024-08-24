//
//  AddLocationCandidateResponseDTO.swift
//
//
//  Created by Ekko on 8/24/24.
//

/*
 {
   "time": "2024-08-24T00:37:32.998Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {
     "placeInfoDto": {
       "title": "string",
       "address": "string",
       "mapx": "string",
       "mapy": "string"
     }
   }
 }
 */

import Domain

public struct AddLocationCandidateResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: ResultDTO
    
    struct ResultDTO: Decodable {
        let placeInfoDto: PlaceInfoDTO
    }
    
    struct PlaceInfoDTO: Decodable {
        let title: String
        let address: String
        let mapx: String
        let mapy: String
    }
}
