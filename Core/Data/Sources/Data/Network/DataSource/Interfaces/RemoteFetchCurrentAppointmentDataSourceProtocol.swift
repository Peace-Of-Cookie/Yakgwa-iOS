//
//  RemoteFetchCurrentAppointmentDataSourceProtocol.swift
//
//
//  Created by Ekko on 8/15/24.
//

import Network

import RxSwift

public protocol RemoteFetchCurrentAppointmentDataSourceProtocol {
    func fetchCurrentAppointments() -> Single<FetchAppointmentDetailResponseDTO>
}
