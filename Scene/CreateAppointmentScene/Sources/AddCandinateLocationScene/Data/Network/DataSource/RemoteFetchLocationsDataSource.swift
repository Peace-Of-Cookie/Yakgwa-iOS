//
//  RemoteFetchLocationsDataSource.swift
//
//
//  Created by Kim Dongjoo on 8/6/24.
//

import Network

import RxSwift

final public class RemoteFetchLocationsDataSource: BaseRemoteDataSource<AddCandinateLocationAPI>, RemoteFetchLocationsDataSourceProtocol {
    public func fetchLocations(query: String) -> RxSwift.Single<SearchLocationDTO> {
        request(
            .fetchLocations(query)
        ).map(SearchLocationDTO.self)
    }
}
