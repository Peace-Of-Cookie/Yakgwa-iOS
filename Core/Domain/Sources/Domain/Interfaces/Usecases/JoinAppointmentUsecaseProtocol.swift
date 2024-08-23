//
//  JoinAppointmentUsecaseProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
//

import RxSwift

public protocol JoinAppointmentUsecaseProtocol {
    func execute(with entity: MeetID) -> Single<Int>
}
