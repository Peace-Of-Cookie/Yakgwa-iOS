//
//  RemoteFetchLocationsDataSource.swift
//
//
//  Created by Kim Dongjoo on 8/5/24.
//

import Network

import RxSwift

final public class RemoteFetchLocationsDataSource: BaseRemoteDataSource<AddAppointmentLocationAPI>, RemoteFetchLocationsDataSourceProtocol {
    public func fetchLocations(query: String) -> RxSwift.Single<SearchLocationDTO> {
        request(
            .fetchLocations(query)
        ).map(SearchLocationDTO.self)
    }
}
