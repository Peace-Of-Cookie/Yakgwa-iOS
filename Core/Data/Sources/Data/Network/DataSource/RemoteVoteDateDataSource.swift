//
//  RemoteVoteDateDataSource.swift
//
//
//  Created by Kim Dongjoo on 8/29/24.
//

import Network

import RxSwift

final public class RemoteVoteDateDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteVoteDateDataSourceProtocol {
    public func voteDate(query: Int, requestDTO: VoteTimeRequestDTO) -> Single<VoteTimeResponseDTO> {
        request(
            .voteTime(query, requestDTO)
        ).map(VoteTimeResponseDTO.self)
    }
}
