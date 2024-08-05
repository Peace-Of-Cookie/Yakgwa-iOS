//
//  AddAppointmentLocationRepository.swift
//
//
//  Created by Kim Dongjoo on 8/5/24.
//

import Network
import RxSwift

public final class AddAppointmentLocationRepository: FetchLocationRepositoryProtocol {
    private let remoteDataSource: RemoteFetchLocationsDataSourceProtocol
    
    public init(remoteDataSource: RemoteFetchLocationsDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchLocations(query: String) -> RxSwift.Single<[Location]> {
        return remoteDataSource
            .fetchLocations(query: query)
            .map { $0.toDomain() }
    }
}
