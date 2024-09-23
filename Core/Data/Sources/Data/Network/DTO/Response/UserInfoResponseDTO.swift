//
//  UserInfoResponseDTO.swift
//  Data
//
//  Created by Kim Dongjoo on 9/23/24.
//

/*
 {
   "time": "2024-09-23T18:44:50.831263967",
   "status": 200,
   "code": "Success",
   "message": "요청에 성공하였습니다.",
   "result": {
     "name": "김동주",
     "imageUrl": "https://yakgwa-bucket-s3.s3.ap-northeast-2.amazonaws.com/yakgwa-user-base-image.png"
   }
 }
 */
import Foundation
import Domain

public struct FetchUserInfoResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: UserInfoDTO
    
    struct UserInfoDTO: Decodable {
        let name: String
        let imageUrl: String
    }
}

extension FetchUserInfoResponseDTO {
    public func toDomain() -> UserInfo {
        return UserInfo(
            name: result.name,
            imageUrl: result.imageUrl
        )
    }
}
