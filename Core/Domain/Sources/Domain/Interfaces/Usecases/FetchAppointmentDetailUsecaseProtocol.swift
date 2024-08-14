//
//  FetchAppointmentDetailUsecaseProtocol.swift
//
//
//  Created by Ekko on 8/15/24.
//

import RxSwift

public protocol FetchAppointmentDetailUsecaseProtocol {
    func execute(with entity: MeetID) -> Single<AppointmentDetail>
}
