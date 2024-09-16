//
//  AddCandidateLocationRepository.swift
//
//
//  Created by Ekko on 9/12/24.
//

import Network
import Domain

import RxSwift

public class AddCandidateLocationRepository: AddCandidateLocationRepositoryProtocol {
    private let remoteDataSource: RemoteAddCandidateLocationDataSourceProtocol
    
    public init(remoteDataSource: RemoteAddCandidateLocationDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func addCandidateLocation(meetId: MeetID, with entity: Location) -> Single<Void> {
        return remoteDataSource
            .addCandidateLocation(query: meetId.getMeetId(), with: AddLocationCandidateRequestDTO(from: entity))
            .map { _ in }
    }
}
