//
//  VoteDateUsecaseProtocol.swift
//
//
//  Created by Ekko on 8/30/24.
//

import RxSwift

public protocol VoteDateUsecaseProtocol {
    func execute(meetId: MeetID, with entity: [VoteDate]) -> Single<Void>
}
