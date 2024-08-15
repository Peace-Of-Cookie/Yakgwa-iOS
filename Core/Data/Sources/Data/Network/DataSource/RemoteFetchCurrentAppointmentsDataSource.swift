//
//  RemoteFetchCurrentAppointmentsDataSource.swift
//
//
//  Created by Ekko on 8/15/24.
//

import Network

import RxSwift

final public class RemoteFetchCurrentAppointmentsDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteFetchCurrentAppointmentDataSourceProtocol {
    public func fetchCurrentAppointments() -> Single<FetchAppointmentDetailResponseDTO> {
        request(
            .fetchCurrentAppointments
        ).map(FetchAppointmentDetailResponseDTO.self)
    }
}
