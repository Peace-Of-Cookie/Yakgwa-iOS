//
//  RemoteFetchLocationsDataSource.swift
//
//
//  Created by Kim Dongjoo on 8/12/24.
//

import Network

import RxSwift

final public class RemoteFetchLocationsDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteFetchLocationsDataSourceProtocol {
    public func fetchLocations(query: String) -> RxSwift.Single<SearchLocationDTO> {
        request(
            .fetchLocations(query)
        ).map(SearchLocationDTO.self)
    }
}
