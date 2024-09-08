//
//  VoteLocationRequestDTO.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Foundation
import Domain

/*
 {
   "currentVotePlaceSlotIds": [
     0
   ]
 }
 */
public struct VoteLocationRequestDTO: Encodable {
    public let currentVotePlaceSlotIds: [Int]
}

public extension VoteLocationRequestDTO {
    init(from entities: [LocationCandidate]) {
        self.currentVotePlaceSlotIds = entities.map { Int($0.id) ?? 0 }
    }
}
