//
//  RemoteFetchAppointmentDetailDataSourceProtocol.swift
//
//
//  Created by Ekko on 8/15/24.
//

import Network

import RxSwift

public protocol RemoteFetchAppointmentDetailDataSourceProtocol {
    func fetchAppointmentDetail(requestDTO: FetchAppointmentDetailRequestDTO) -> Single<FetchAppointmentDetailResponseDTO>
}
