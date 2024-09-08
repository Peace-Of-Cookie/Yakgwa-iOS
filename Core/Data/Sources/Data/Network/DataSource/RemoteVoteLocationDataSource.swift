//
//  RemoteVoteLocationDataSource.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Network

import RxSwift

final public class RemoteVoteLocationDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteVoteLocationDataSourceProtocol {
    public func voteLocation(query: Int, reqeustDTO: VoteLocationRequestDTO) -> Single<VoteLocationResponseDTO> {
        request(
            .voteLocation(query, reqeustDTO)
        ).map(VoteLocationResponseDTO.self)
    }
}
