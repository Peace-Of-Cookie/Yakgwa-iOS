//
//  FetchThemeUsecases.swift
//
//
//  Created by Kim Dongjoo on 8/1/24.
//

import RxSwift

/// 테마 목록 패치 유스케이스
public final class FetchThemeUsecase: FetchThemeUsecaseProtocol {
    
    private let repository: FetchThemeRepositoryProtocol
    
    public init(repository: FetchThemeRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() -> Single<[Theme]> {
        return repository.fetchThemes()
    }
}
