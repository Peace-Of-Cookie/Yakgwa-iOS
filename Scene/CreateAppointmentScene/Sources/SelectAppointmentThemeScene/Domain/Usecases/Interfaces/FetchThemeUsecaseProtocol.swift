//
//  FetchThemeUsecaseProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/1/24.
//

import RxSwift

public protocol FetchThemeUsecaseProtocol {
    func execute() -> Single<[Theme]>
}
