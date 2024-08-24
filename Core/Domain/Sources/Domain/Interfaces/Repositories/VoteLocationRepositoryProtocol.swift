//
//  VoteLocationRepositoryProtocol.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Network

import RxSwift

public protocol VoteLocationRepositoryProtocol {
    func voteLocation(meetId: Int, with entity: [LocationCandidate]) -> Single<Void>
}
