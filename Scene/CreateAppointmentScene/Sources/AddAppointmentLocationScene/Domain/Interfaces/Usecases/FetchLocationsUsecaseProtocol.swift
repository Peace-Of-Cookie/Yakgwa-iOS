//
//  FetchLocationsUsecaseProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/5/24.
//

import RxSwift

public protocol FetchLocationsUsecaseProtocol {
    func execute(query: String) -> Single<[Location]>
}
