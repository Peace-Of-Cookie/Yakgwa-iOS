//
//  VoteDateRepository.swift
//
//
//  Created by Ekko on 8/30/24.
//

import Network
import Domain

import RxSwift

public class VoteDateRepository: VoteDateRepositoryProtocol {
    private let remoteDataSource: RemoteVoteDateDataSourceProtocol
    
    public init(remoteDataSource: RemoteVoteDateDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func voteDate(meetId: MeetID, with entity: [VoteDate]) -> Single<Void> {
        return remoteDataSource
            .voteDate(query: meetId.getMeetId(), requestDTO: VoteTimeRequestDTO(from: entity))
            .map { _ in }
    }
}
