//
//  FetchDateCandidatesRepository.swift
//
//
//  Created by Kim Dongjoo on 8/27/24.
//

import Network
import RxSwift
import Domain

public final class FetchDateCandidatesRepository: FetchDateCandidatesRepositoryProtocol {
    private let remoteDataSource: RemoteFetchDateCandidatesDataSourceProtocol
    
    public init(remoteDataSource: RemoteFetchDateCandidatesDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchDateCandidates(with entity: MeetID) -> Single<VoteDateInfo> {
        return remoteDataSource
            .fetchDateCandidates(query: entity.getMeetId())
            .map { $0.toDomain() }
    }
}
