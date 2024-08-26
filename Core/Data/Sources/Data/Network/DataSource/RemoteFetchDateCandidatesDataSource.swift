//
//  RemoteFetchDateCandidatesDataSource.swift
//
//
//  Created by Ekko on 8/26/24.
//

import Network

import RxSwift

final public class RemoteFetchDateCandidatesDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteFetchDateCandidatesDataSourceProtocol {
    public func fetchDateCandidates(query: Int) -> Single<FetchDateCandidateResponseDTO> {
        request(
            .fetchDateCandidates(query)
        ).map(FetchDateCandidateResponseDTO.self)
    }
}
