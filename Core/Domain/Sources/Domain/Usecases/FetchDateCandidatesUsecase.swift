//
//  FetchDateCandidatesUsecase.swift
//
//
//  Created by Kim Dongjoo on 8/27/24.
//

import RxSwift

public final class FetchDateCandidatesUsecase: FetchDateCandidatesUsecaseProtocol {
    private let repository: FetchDateCandidatesRepositoryProtocol
    
    public init(repository: FetchDateCandidatesRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(with entity: MeetID) -> Single<VoteDateInfo> {
        return repository.fetchDateCandidates(with: entity)
    }
}
