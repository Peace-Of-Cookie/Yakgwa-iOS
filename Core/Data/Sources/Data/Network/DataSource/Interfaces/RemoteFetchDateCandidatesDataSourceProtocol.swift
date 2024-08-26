//
//  RemoteFetchDateCandidatesDataSourceProtocol.swift
//
//
//  Created by Ekko on 8/26/24.
//

import Network

import RxSwift

public protocol RemoteFetchDateCandidatesDataSourceProtocol {
    func fetchDateCandidates(query: Int) -> Single<FetchDateCandidateResponseDTO>
}

