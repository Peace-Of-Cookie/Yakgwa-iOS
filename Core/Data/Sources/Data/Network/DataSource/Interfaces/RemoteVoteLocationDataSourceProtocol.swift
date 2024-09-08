//
//  RemoteVoteLocationDataSourceProtocol.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Network

import RxSwift

public protocol RemoteVoteLocationDataSourceProtocol {
    func voteLocation(query: Int, reqeustDTO: VoteLocationRequestDTO) -> Single<VoteLocationResponseDTO>
}
