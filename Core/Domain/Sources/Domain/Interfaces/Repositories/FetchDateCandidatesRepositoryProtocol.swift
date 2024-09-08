//
//  FetchDateCandidatesRepositoryProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/27/24.
//

import Network

import RxSwift

public protocol FetchDateCandidatesRepositoryProtocol {
    func fetchDateCandidates(with entity: MeetID) -> Single<VoteDateInfo>
}
