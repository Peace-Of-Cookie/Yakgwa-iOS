//
//  FetchLocationCandidateUsecaseProtocol.swift
//
//
//  Created by Ekko on 8/24/24.
//

import RxSwift

public protocol FetchLocationCandidateUsecaseProtocol {
    func execute(with entity: MeetID) -> Single<[LocationCandidate]>
}
