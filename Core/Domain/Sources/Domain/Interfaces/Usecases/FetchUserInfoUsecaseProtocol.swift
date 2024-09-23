//
//  FetchUserInfoUsecaseProtocol.swift
//  Domain
//
//  Created by Kim Dongjoo on 9/23/24.
//

import RxSwift

public protocol FetchUserInfoUsecaseProtocol {
    func execute() -> Single<Void>
}
