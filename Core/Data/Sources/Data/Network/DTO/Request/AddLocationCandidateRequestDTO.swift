//
//  AddLocationCadidateRequestDTO.swift
//
//
//  Created by Ekko on 8/24/24.
//

/*
 {
   "placeInfo": {
     "title": "스타벅스 강남역점",
     "link": "www.starbucks.com",
     "category": "cafe",
     "description": "스타벅스",
     "telephone": "02-xxx-xxx",
     "address": "도곡동 956 LG전자 강남R&D센터",
     "roadAddress": "서울특별시 강남구 강남대로 390",
     "mapx": "232",
     "mapy": "123"
   }
 }
 */
import Foundation
import Domain

public struct AddLocationCandidateRequestDTO: Encodable {
    let placeInfo: PlaceInfoDTO
    
    struct PlaceInfoDTO: Encodable {
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

public extension AddLocationCandidateRequestDTO {
    init(from entity: Location) {
        let title = entity.getTitle() ?? ""
        let link = entity.getLink() ?? ""
        let category = entity.getCategory() ?? ""
        let description = entity.getDescription() ?? ""
        let telephone = entity.getTelephone() ?? ""
        let address = entity.getAddress() ?? ""
        let roadAddress = entity.getRoadAddress() ?? ""
        let mapx = entity.getMapx() ?? ""
        let mapy = entity.getMapy() ?? ""
        
        placeInfo = PlaceInfoDTO(title: title, link: link, category: category, description: description, telephone: telephone, address: address, roadAddress: roadAddress, mapx: mapx, mapy: mapy)
    }
}
