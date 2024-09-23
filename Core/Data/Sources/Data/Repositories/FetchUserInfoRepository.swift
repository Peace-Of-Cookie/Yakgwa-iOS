//
//  FetchUserInfoRepository.swift
//  Data
//
//  Created by Kim Dongjoo on 9/23/24.
//

import Network
import RxSwift
import Domain

public final class FetchUserInfoRepository: FetchUserInfoRepositoryProtocol {
    private let remoteDataSource: RemoteFetchUserInfoDataSourceProtocol
    
    public init(remoteDataSource: RemoteFetchUserInfoDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchUserInfo() -> Single<Void> {
        return remoteDataSource.fetchUserInfo()
            .map { _ in }
    }
}
