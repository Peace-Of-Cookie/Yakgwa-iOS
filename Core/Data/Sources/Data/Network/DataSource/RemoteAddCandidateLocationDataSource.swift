//
//  RemoteAddCandidateLocationDataSource.swift
//
//
//  Created by Ekko on 9/12/24.
//

import Network

import RxSwift

final public class RemoteAddCandidateLocationDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteAddCandidateLocationDataSourceProtocol {
    public func addCandidateLocation(query: Int, with dto: AddLocationCandidateRequestDTO) -> RxSwift.Single<Void> {
        request(
            .addLocationCandidates(query, dto)
        ).map { _ in }
    }
}
