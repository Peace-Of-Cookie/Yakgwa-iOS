//
//  FetchLocationRepositoryProtocol.swift
//  
//
//  Created by Kim Dongjoo on 8/6/24.
//

import Network
import Domain
import RxSwift

public protocol FetchLocationRepositoryProtocol {
    func fetchLocations(query: String) -> Single<[Location]>
}
