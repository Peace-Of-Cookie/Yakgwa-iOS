//
//  FetchMyVoteLocationsRepositoryProtocol.swift
//
//
//  Created by Ekko on 8/25/24.
//

import Network

import RxSwift

public protocol FetchMyVoteLocationsRepositoryProtocol {
    func fetchMyVoteLocations(with entity: MeetID) -> Single<VoteLocationInfo>
}
