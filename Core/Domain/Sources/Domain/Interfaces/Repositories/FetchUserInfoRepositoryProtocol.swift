//
//  FetchUserInfoRepositoryProtocol.swift
//  Domain
//
//  Created by Kim Dongjoo on 9/23/24.
//

import Network

import RxSwift

public protocol FetchUserInfoRepositoryProtocol {
    func fetchUserInfo() -> Single<UserInfo>
}
