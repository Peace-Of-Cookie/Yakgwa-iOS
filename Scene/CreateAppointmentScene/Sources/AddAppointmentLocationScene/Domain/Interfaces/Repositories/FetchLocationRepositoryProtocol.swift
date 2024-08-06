//
//  FetchLocationRepositoryProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/5/24.
//

import Network
import RxSwift

public protocol FetchLocationRepositoryProtocol {
    func fetchLocations(query: String) -> Single<[Location]>
}
