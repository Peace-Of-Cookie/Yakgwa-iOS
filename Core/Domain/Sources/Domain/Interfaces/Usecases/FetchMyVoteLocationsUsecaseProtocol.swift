//
//  FetchMyVoteLocationsUsecaseProtocol.swift
//
//
//  Created by Ekko on 8/25/24.
//

import RxSwift

public protocol FetchMyVoteLocationsUsecaseProtocol {
    func execute(with entity: MeetID) -> Single<VoteLocationInfo>
}
