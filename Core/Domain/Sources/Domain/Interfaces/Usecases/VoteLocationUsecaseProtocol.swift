//
//  VoteLocationUsecaseProtocol.swift
//
//
//  Created by Ekko on 8/24/24.
//

import RxSwift

public protocol VoteLocationUsecaseProtocol {
    func execute(meetId: Int, with entity: [LocationCandidate]) -> Single<Void>
}
