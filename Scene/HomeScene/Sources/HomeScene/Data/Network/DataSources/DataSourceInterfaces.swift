//
//  DataSourceInterfaces.swift
//
//
//  Created by Ekko on 7/24/24.
//

import Network

import RxSwift

public protocol RemoteFetchAppointmentDataSourceProtocol {
    func fetchAppointments() -> Single<MeetResponseDTO>
}
