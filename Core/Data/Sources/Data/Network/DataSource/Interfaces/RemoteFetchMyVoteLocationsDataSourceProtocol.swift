//
//  RemoteFetchMyVoteLocationsDataSourceProtocol.swift
//
//
//  Created by Ekko on 8/25/24.
//

import Network

import RxSwift

public protocol RemoteFetchMyVoteLocationsDataSourceProtocol {
    func fetchMyVoteLocations(query: Int) -> Single<FetchMyVoteLocationsResponseDTO>
}
