//
//  FetchLocationsUsecaseProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/12/24.
//

import RxSwift

public protocol FetchLocationsUsecaseProtocol {
    func execute(query: String) -> Single<[Location]>
}

