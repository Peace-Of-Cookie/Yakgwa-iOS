//
//  CreateAppointmentRequestDTO.swift
//
//
//  Created by Kim Dongjoo on 8/13/24.
//

/*
 {
   "meetInfo": {
     "meetTitle": "다음 세션 모임",
     "description": "다음세션화이팅!",
     "meetThemeId": 1,
     "confirmPlace": true,
     "placeInfo": [
       {
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
     ],
     "voteDate": {
       "startVoteDate": "2024-07-10",
       "endVoteDate": "2024-07-10"
     },
     "meetTime": "2024-08-13T06:15:33.146Z"
   }
 }
 */
import Foundation
import Domain

/// api/v1/meets
public struct CreateAppointmentRequestDTO: Encodable {
    let meetInfo: MeetInfoDTO
    
    struct MeetInfoDTO: Encodable {
        var meetTitle: String
        let description: String
        let meetThemeId: Int
        let confirmPlace: Bool
        let placeInfo: [PlaceInfoDTO]
        let voteDate: VoteDateDTO
        let meetTime: String
        
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
        
        struct VoteDateDTO: Encodable {
            let startVoteDate: String
            let endVoteDate: String
        }
    }
}

public extension CreateAppointmentRequestDTO {
    init(from entity: NewAppointment) {
        // MeetInfoDTO 구성
        let meetTitle = entity.getTitle() ?? ""
        let description = entity.getDescription() ?? ""
        let meetThemeId = entity.getThemeId() ?? 0
        let confirmPlace = (entity.getLocation() != nil)
        
        let placeInfo: [MeetInfoDTO.PlaceInfoDTO] = entity.getCandidateLocations()?.map { location in
            return MeetInfoDTO.PlaceInfoDTO(
                title: location.title ?? "",
                link: location.link ?? "",
                category: location.category ?? "",
                description: location.description ?? "",
                telephone: location.telephone ?? "",
                address: location.address ?? "",
                roadAddress: location.roadAddress ?? "",
                mapx: location.mapx ?? "",
                mapy: location.mapy ?? ""
            )
        } ?? []
        
        let voteDate: MeetInfoDTO.VoteDateDTO
        if let startDate = entity.getStartDate(), let endDate = entity.getEndDate() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let startVoteDate = dateFormatter.string(from: startDate)
            let endVoteDate = dateFormatter.string(from: endDate)
            voteDate = MeetInfoDTO.VoteDateDTO(startVoteDate: startVoteDate, endVoteDate: endVoteDate)
        } else {
            voteDate = MeetInfoDTO.VoteDateDTO(startVoteDate: "", endVoteDate: "")
        }
        
        let meetTime: String
        if let date = entity.getDate(), let time = entity.getTime() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            meetTime = dateFormatter.string(from: date) + " " + dateFormatter.string(from: time)
        } else {
            meetTime = ""
        }
        
        self.meetInfo = MeetInfoDTO(
            meetTitle: meetTitle,
            description: description,
            meetThemeId: meetThemeId,
            confirmPlace: confirmPlace,
            placeInfo: placeInfo,
            voteDate: voteDate,
            meetTime: meetTime
        )
    }
}
