//
//  RemoteFetchAppointmentDetailDataSource.swift
//
//
//  Created by Ekko on 8/15/24.
//

import Network

import RxSwift

final public class RemoteFetchAppointmentDetailDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteFetchAppointmentDetailDataSourceProtocol {
    public func fetchAppointmentDetail(requestDTO: FetchAppointmentDetailRequestDTO) -> Single<FetchAppointmentDetailResponseDTO> {
        request(
            .fetchAppointmentDetail(requestDTO)
        ).map(FetchAppointmentDetailResponseDTO.self)
    }
}
