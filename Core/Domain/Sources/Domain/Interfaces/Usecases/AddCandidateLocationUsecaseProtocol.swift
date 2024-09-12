//
//  AddCandidateLocationUsecaseProtocol.swift
//
//
//  Created by Ekko on 9/12/24.
//

import RxSwift

public protocol AddCandidateLocationUsecaseProtocol {
    func execute(meetId: MeetID, with entity: Location) -> Single<Void>
}
