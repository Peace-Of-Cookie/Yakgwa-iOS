//
//  VoteDateRepositoryProtocol.swift
//
//
//  Created by Ekko on 8/30/24.
//

import Network

import RxSwift

public protocol VoteDateRepositoryProtocol {
    func voteDate(meetId: MeetID, with entity: [VoteDate]) -> Single<Void>
}
