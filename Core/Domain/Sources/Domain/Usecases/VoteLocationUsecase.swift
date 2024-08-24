//
//  VoteLocationUsecase.swift
//
//
//  Created by Ekko on 8/24/24.
//

import RxSwift

public final class VoteLocationUsecase: VoteLocationUsecaseProtocol {
    private let repository: VoteLocationRepositoryProtocol
    
    public init(repository: VoteLocationRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(meetId: Int, with entity: [LocationCandidate]) -> Single<Void> {
        return repository.voteLocation(meetId: meetId, with: entity)
    }
}
