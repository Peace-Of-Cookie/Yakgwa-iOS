//
//  RemoteJoinAppointmentDataSourceProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
//

import Network

import RxSwift

public protocol RemoteJoinAppointmentDataSourceProtocol {
    func joinAppointment(requestDTO: JoinAppointmentRequestDTO) -> Single<JoinAppointmentResponseDTO>
}
