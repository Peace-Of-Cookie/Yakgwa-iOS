//
//  RemoteFetchLocationCandidateDataSource.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Network

import RxSwift

final public class RemoteFetchLocationCandidateDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteFetchLocationCandidatesDataSourceProtocol {
    public func fetchCandidates(query: Int) -> Single<FetchLocationCandindateResponseDTO> {
        request(
            .fetchLocationCandidates(query)
        ).map(FetchLocationCandindateResponseDTO.self)
    }
}
