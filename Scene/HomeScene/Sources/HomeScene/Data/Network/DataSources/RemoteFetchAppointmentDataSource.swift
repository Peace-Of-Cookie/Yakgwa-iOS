//
//  RemoteFetchAppointmentDataSource.swift
//
//
//  Created by Ekko on 7/24/24.
//

import Network

import RxSwift

final class RemoteFetchAppointmentDataSource: BaseRemoteDataSource<HomeAPI>, RemoteFetchAppointmentDataSourceProtocol {
    func fetchAppointments() -> Single<MeetResponseDTO> {
        request(
            .fetchAppointments
        ).map(MeetResponseDTO.self)
    }
}
