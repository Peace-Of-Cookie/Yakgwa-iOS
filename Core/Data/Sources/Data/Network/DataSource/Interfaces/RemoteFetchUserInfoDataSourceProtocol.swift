//
//  RemoteFetchUserInfoDataSourceProtocol.swift
//  Data
//
//  Created by Kim Dongjoo on 9/23/24.
//

import Network

import RxSwift

public protocol RemoteFetchUserInfoDataSourceProtocol {
    func fetchUserInfo() -> Single<FetchUserInfoResponseDTO>
}
