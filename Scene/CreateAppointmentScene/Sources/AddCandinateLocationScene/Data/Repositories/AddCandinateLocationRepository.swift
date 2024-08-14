//
//  AddCandinateLocationRepository.swift
//
//
//  Created by Kim Dongjoo on 8/6/24.
//

import Network
import RxSwift
import Domain

public final class AddCandinateLocationRepository: FetchLocationRepositoryProtocol {
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

