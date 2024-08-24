//
//  CandidateViewModel.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Foundation
import Domain

public struct CandidateViewModel: Equatable {
    let title: String
    var address: String = ""
    var userInfo: [Participant] = []
}

extension CandidateViewModel {
    init(with entity: LocationCandidate) {
        self.title = entity.title
        self.address = entity.address
        self.userInfo = entity.userInfo
    }
}
