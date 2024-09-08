//
//  FetchMyVoteLocationsUsecase.swift
//
//
//  Created by Ekko on 8/25/24.
//

import RxSwift

public final class FetchMyVoteLocationsUsecase: FetchMyVoteLocationsUsecaseProtocol {
    private let repository: FetchMyVoteLocationsRepositoryProtocol
    
    public init(repository: FetchMyVoteLocationsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(with entity: MeetID) -> Single<VoteLocationInfo> {
        return repository.fetchMyVoteLocations(with: entity)
    }
}
