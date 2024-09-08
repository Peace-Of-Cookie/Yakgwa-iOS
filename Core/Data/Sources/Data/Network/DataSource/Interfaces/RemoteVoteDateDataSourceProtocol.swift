//
//  RemoteVoteDateDataSourceProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/29/24.
//

import Network

import RxSwift

public protocol RemoteVoteDateDataSourceProtocol {
    func voteDate(query: Int, requestDTO: VoteTimeRequestDTO) -> Single<VoteTimeResponseDTO>
}
