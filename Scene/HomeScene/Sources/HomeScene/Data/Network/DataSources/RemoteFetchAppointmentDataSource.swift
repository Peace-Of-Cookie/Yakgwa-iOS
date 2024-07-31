//
//  RemoteFetchAppointmentDataSource.swift
//
//
//  Created by Ekko on 7/24/24.
//

import Network

import RxSwift

final public class RemoteFetchAppointmentDataSource: BaseRemoteDataSource<HomeAPI>, RemoteFetchAppointmentDataSourceProtocol {
    public func fetchAppointments() -> Single<MeetResponseDTO> {
        request(
            .fetchAppointments
        ).map(MeetResponseDTO.self)
    }
}
