//
//  RemoteFetchMyVoteLocationsDataSource.swift
//
//
//  Created by Ekko on 8/25/24.
//

import Network

import RxSwift

final public class RemoteFetchMyVoteLocationsDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteFetchMyVoteLocationsDataSourceProtocol {
    public func fetchMyVoteLocations(query: Int) -> Single<FetchMyVoteLocationsResponseDTO> {
        request(
            .fetchMyVoteLocation(query)
        ).map(FetchMyVoteLocationsResponseDTO.self)
    }
}
