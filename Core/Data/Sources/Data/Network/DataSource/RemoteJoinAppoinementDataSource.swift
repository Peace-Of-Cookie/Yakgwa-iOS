//
//  RemoteJoinAppoinementDataSource.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
//

import Network

import RxSwift

final public class RemoteJoinAppoinementDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteJoinAppointmentDataSourceProtocol {
    public func joinAppointment(requestDTO: JoinAppointmentRequestDTO) -> Single<JoinAppointmentResponseDTO> {
        request(
            .joinAppointment(requestDTO)
        ).map(JoinAppointmentResponseDTO.self)
    }
}
