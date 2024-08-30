//
//  VoteDateUsecase.swift
//
//
//  Created by Ekko on 8/30/24.
//

import RxSwift

public final class VoteDateUsecase: VoteDateUsecaseProtocol {
    private let repository: VoteDateRepositoryProtocol
    
    public init(repository: VoteDateRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(meetId: MeetID, with entity: [VoteDate]) -> Single<Void> {
        return repository.voteDate(meetId: meetId, with: entity)
    }
}
