//
//  RemoteCreateAppointmentDataSource.swift
//
//
//  Created by Kim Dongjoo on 8/13/24.
//

import Network

import RxSwift

final public class RemoteCreateAppointmentDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteCreateAppointmentDataSourceProtocol {
    public func createAppointment(with dto: CreateAppointmentRequestDTO) -> RxSwift.Single<CreateAppointmentResponseDTO> {
        request(
            .createAppointment(dto)
        ).map(CreateAppointmentResponseDTO.self)
    }
}
