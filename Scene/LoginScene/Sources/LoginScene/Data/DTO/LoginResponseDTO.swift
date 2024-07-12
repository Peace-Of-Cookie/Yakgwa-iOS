//
//  LoginResponseDTO.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import Foundation

/// 로그인 응답 DTO
public struct LoginResponseDTO: Codable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: LoginResult
    
    struct LoginResult: Codable {
        let tokenSet: TokenSet
        let isNew: Bool
        
        struct TokenSet: Codable {
            let accessToken: String
            let refreshToken: String
        }
    }
}
