//
//  RemoteFetchThemeDataSource.swift
//
//
//  Created by Kim Dongjoo on 8/1/24.
//

import Network

import RxSwift

final public class RemoteFetchThemeDataSource: BaseRemoteDataSource<SelectAppointmentThemeAPI>, RemoteFetchThemeDataSourceProtocol {
    public func fetchThemes() -> RxSwift.Single<ThemeResponseDTO> {
        request(
            .fetchThemes
        ).map(ThemeResponseDTO.self)
    }
}
