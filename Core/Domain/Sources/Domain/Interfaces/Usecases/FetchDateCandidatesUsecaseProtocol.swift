//
//  FetchDateCandidatesUsecaseProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/27/24.
//

import RxSwift

public protocol FetchDateCandidatesUsecaseProtocol {
    func execute(with entity: MeetID) -> Single<VoteDateInfo>
}
