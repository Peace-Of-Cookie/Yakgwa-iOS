//
//  FetchLocationCandidateRepositoryProtocol.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Network

import RxSwift

public protocol FetchLocationCandidateRepositoryProtocol {
    func fetchCandidates(with entity: MeetID) -> Single<[LocationCandidate]>
}
