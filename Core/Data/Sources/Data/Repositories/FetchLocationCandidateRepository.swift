//
//  FetchLocationCandidateRepository.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Network
import RxSwift
import Domain

public final class FetchLocationCandidateRepository: FetchLocationCandidateRepositoryProtocol {
    private let remoteDataSource: RemoteFetchLocationCandidatesDataSourceProtocol
    
    public init(remoteDataSource: RemoteFetchLocationCandidatesDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchCandidates(with entity: MeetID) -> Single<[LocationCandidate]> {
        return remoteDataSource
            .fetchCandidates(query: entity.getMeetId())
            .map { $0.toDomain() }
    }
}
