//
//  AddCandidateLocationRepositoryProtocol.swift
//
//
//  Created by Ekko on 9/12/24.
//

import Network

import RxSwift

public protocol AddCandidateLocationRepositoryProtocol {
    func addCandidateLocation(meetId: MeetID, with entity: Location) -> Single<Void>
}
