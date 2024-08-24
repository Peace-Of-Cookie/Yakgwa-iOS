//
//  FetchLocationCandidateUsecase.swift
//
//
//  Created by Ekko on 8/24/24.
//

import RxSwift

public final class FetchLocationCandidateUsecase: FetchLocationCandidateUsecaseProtocol {
    private let repository: FetchLocationCandidateRepositoryProtocol
    
    public init(repository: FetchLocationCandidateRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(with entity: MeetID) -> Single<[LocationCandidate]> {
        return repository.fetchCandidates(with: entity)
    }
}
