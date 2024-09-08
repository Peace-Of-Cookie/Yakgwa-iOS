//
//  VoteTimeRequestDTO.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Foundation
import Domain

/*
 {
   "enableTimes": [
     {
       "enableTime": "2024-08-24 02:00"
     }
   ]
 }
 */

public struct VoteTimeRequestDTO: Encodable {
    public let enableTimes: [EnableTimeDTO]
    
    public struct EnableTimeDTO: Encodable {
        public let enableTime: String
    }
}

public extension VoteTimeRequestDTO {
    init(from entities: [VoteDate]) {
        self.enableTimes = entities.map { EnableTimeDTO(enableTime: $0.getVoteDateString()) }
    }
}
