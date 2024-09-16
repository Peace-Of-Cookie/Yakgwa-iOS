//
//  SearchLocationResponseDTO.swift
//
//
//  Created by Kim Dongjoo on 9/11/24.
//

import Foundation
import Domain

public struct SearchLocationResponseDTO: Decodable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: [LocationDTO]
    
    struct LocationDTO: Decodable {
        let placeInfoDto: PlaceInfoDTO
        let isUserLike: Bool
        
        struct PlaceInfoDTO: Decodable {
            let title: String
            let link: String
            let category: String
            let description: String
            let telephone: String
            let address: String
            let roadAddress: String
            let mapx: String
            let mapy: String
        }
    }
}

extension SearchLocationResponseDTO {
    func toDomain() -> [Location] {
        return result.map { locationDTO in
            Location(
                title: locationDTO.placeInfoDto.title,
                link: locationDTO.placeInfoDto.link,
                category: locationDTO.placeInfoDto.category,
                description: locationDTO.placeInfoDto.description,
                telephone: locationDTO.placeInfoDto.telephone,
                address: locationDTO.placeInfoDto.address,
                roadAddress: locationDTO.placeInfoDto.roadAddress,
                mapx: locationDTO.placeInfoDto.mapx,
                mapy: locationDTO.placeInfoDto.mapy
            )
        }
    }
}
