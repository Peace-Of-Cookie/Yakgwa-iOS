//
//  File.swift
//  
//
//  Created by Kim Dongjoo on 8/5/24.
//

import Network

import RxSwift

public protocol RemoteFetchLocationsDataSourceProtocol {
    func fetchLocations(query: String) -> Single<SearchLocationDTO>
}
