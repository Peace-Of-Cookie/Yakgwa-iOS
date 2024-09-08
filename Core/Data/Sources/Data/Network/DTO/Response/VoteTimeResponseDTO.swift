//
//  VoteTimeResponseDTO.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Foundation

import Domain

public struct VoteTimeResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
}
