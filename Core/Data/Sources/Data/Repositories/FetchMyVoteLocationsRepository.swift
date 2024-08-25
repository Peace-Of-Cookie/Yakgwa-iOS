//
//  FetchMyVoteLocationsRepository.swift
//
//
//  Created by Ekko on 8/25/24.
//

import Network
import RxSwift
import Domain

public final class FetchMyVoteLocationsRepository: FetchMyVoteLocationsRepositoryProtocol {
    private let remoteDataSource: RemoteFetchMyVoteLocationsDataSourceProtocol

    public init(remoteDataSource: RemoteFetchMyVoteLocationsDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    public func fetchMyVoteLocations(with entity: MeetID) -> Single<VoteLocationInfo> {
        return remoteDataSource
            .fetchMyVoteLocations(query: entity.getMeetId())
            .map { $0.toDomain() }
    }
}
