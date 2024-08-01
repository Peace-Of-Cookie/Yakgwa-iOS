//
//  ThemeResponseDTO.swift
//
//
//  Created by Kim Dongjoo on 8/1/24.
//

// http://yakgwa.site/api/v1/theme
/*
 {
     "time": "2024-08-01T15:34:14.27604154",
     "status": 200,
     "code": "Success",
     "message": "요청에 성공하였습니다.",
     "result": [
         {
             "id": 1,
             "name": "데이트"
         },
         {
             "id": 2,
             "name": "맛집"
         },
         {
             "id": 3,
             "name": "여행"
         }
     ]
 }
 */
/// /theme DTO
public struct ThemeResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: [ThemeDTO]
    
    struct ThemeDTO: Decodable {
        let id: Int
        let name: String
    }
}

extension ThemeResponseDTO {
    /// ThemeResponseDTO -> [Theme]([Entity])
    func toDomain() -> [Theme] {
        return result.map { $0.toDomain() }
    }
}

extension ThemeResponseDTO.ThemeDTO {
    /// ThemeResponseDTO.ThemeDTO -> Theme(Entity)
    func toDomain() -> Theme {
        return Theme(
            id: id,
            themeName: name
        )
    }
}
