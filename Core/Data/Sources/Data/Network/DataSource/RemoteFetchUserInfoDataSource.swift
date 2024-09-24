//
//  RemoteFetchUserInfoDataSource.swift
//  Data
//
//  Created by Kim Dongjoo on 9/23/24.
//

import Network

import RxSwift

final public class RemoteFetchUserInfoDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteFetchUserInfoDataSourceProtocol {
    public func fetchUserInfo() -> Single<FetchUserInfoResponseDTO> {
        request(
            .fetchUserInfo
        ).map(FetchUserInfoResponseDTO.self)
    }
}
