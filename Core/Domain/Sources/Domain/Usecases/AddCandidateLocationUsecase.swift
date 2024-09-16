//
//  AddCandidateLocationUsecase.swift
//
//
//  Created by Ekko on 9/12/24.
//

import RxSwift

public final class AddCandidateLocationUsecase: AddCandidateLocationUsecaseProtocol {
    private let reposiroty: AddCandidateLocationRepositoryProtocol
    
    public init(reposiroty: AddCandidateLocationRepositoryProtocol) {
        self.reposiroty = reposiroty
    }
    
    public func execute(meetId: MeetID, with entity: Location) -> Single<Void> {
        return reposiroty.addCandidateLocation(meetId: meetId, with: entity)
    }
}
