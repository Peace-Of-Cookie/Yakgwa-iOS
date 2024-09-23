//
//  FetchUserInfoUsecase.swift
//  Domain
//
//  Created by Kim Dongjoo on 9/23/24.
//

import RxSwift

public final class FetchUserInfoUsecase: FetchUserInfoUsecaseProtocol {
    private let repository: FetchUserInfoRepositoryProtocol
    
    public init(repository: FetchUserInfoRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() -> Single<UserInfo> {
        return repository.fetchUserInfo()
    }
}
