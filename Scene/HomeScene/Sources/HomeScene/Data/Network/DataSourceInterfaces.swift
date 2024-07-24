//
//  DataSourceInterfaces.swift
//
//
//  Created by Ekko on 7/24/24.
//

import Network

import RxSwift

protocol RemoteFetchAppointmentDataSourceProtocol {
    func fetchAppointments() -> Single<MeetResponseDTO>
}
