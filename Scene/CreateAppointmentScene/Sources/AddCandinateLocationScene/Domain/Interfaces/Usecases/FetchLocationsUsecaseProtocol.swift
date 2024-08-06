//
//  FetchLocationsUsecaseProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/6/24.
//

import RxSwift
import Domain

public protocol FetchLocationsUsecaseProtocol {
    func execute(query: String) -> Single<[Location]>
}

