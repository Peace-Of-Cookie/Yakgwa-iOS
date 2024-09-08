//
//  RemoteFetchLocationCandidatesDataSourceProtocol.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Network

import RxSwift

public protocol RemoteFetchLocationCandidatesDataSourceProtocol {
    func fetchCandidates(query: Int) -> Single<FetchLocationCandindateResponseDTO>
}
