//
//  FetchLocationsUsecase.swift
//
//
//  Created by Kim Dongjoo on 8/5/24.
//

import RxSwift

public final class FetchLocationsUsecase: FetchLocationsUsecaseProtocol {
    private let repository: FetchLocationRepositoryProtocol
    
    public init(repository: FetchLocationRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(query: String) -> Single<[Location]> {
        return repository.fetchLocations(query: query)
    }
}
