//
//  FetchThemeRepository.swift
//
//
//  Created by Kim Dongjoo on 8/1/24.
//

import Network
import RxSwift

public final class FetchThemeRepository: FetchThemeRepositoryProtocol {
    private let remoteDataSource: RemoteFetchThemeDataSourceProtocol
    
    public init(remoteDataSource: RemoteFetchThemeDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchThemes() -> Single<[Theme]> {
        remoteDataSource
            .fetchThemes()
            .map {
                $0.toDomain()
            }
    }
}
