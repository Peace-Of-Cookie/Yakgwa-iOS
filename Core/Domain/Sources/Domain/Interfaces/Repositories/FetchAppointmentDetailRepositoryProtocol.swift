//
//  FetchAppointmentDetailRepositoryProtocol.swift
//
//
//  Created by Ekko on 8/15/24.
//

import Network

import RxSwift

public protocol FetchAppointmentDetailRepositoryProtocol {
    func fetchAppointmentDetail(with entity: MeetID) -> Single<AppointmentDetail>
}
