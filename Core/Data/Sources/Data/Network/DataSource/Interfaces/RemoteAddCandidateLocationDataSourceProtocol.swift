//
//  RemoteAddCandidateLocationDataSourceProtocol.swift
//
//
//  Created by Ekko on 9/12/24.
//

import Network

import RxSwift

public protocol RemoteAddCandidateLocationDataSourceProtocol {
    func addCandidateLocation(
        query: Int,
        with dto: AddLocationCandidateRequestDTO
    ) -> Single<Void>
}
