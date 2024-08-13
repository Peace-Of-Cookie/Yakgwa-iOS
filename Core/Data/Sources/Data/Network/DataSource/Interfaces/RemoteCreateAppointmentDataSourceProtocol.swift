//
//  RemoteCreateAppointmentDataSourceProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/13/24.
//

import Network

import RxSwift

public protocol RemoteCreateAppointmentDataSourceProtocol {
    func createAppointment(with dto: CreateAppointmentRequestDTO) -> Single<CreateAppointmentResponseDTO>
}
