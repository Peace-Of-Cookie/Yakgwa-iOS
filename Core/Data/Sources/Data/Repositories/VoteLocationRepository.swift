//
//  VoteLocationRepository.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Network
import Domain

import RxSwift

public class VoteLocationRepository: VoteLocationRepositoryProtocol {
    private let remoteDataSource: RemoteVoteLocationDataSourceProtocol
    
    public init(remoteDataSource: RemoteVoteLocationDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func voteLocation(meetId: MeetID, with entity: [LocationCandidate]) -> Single<Void> {
        return remoteDataSource
            .voteLocation(query: meetId.getMeetId(), reqeustDTO: VoteLocationRequestDTO(from: entity))
            .map { _ in }
    }
}
