//
//  VoteLocationInfo.swift
//
//
//  Created by Ekko on 8/25/24.
//

import Foundation

public struct VoteLocationInfo: Equatable {
    let meetStatus: MeetStatus?
    var placeInfos: [PlaceInfo] = []
    
    public struct PlaceInfo: Equatable {
        let placeSlotId: Int?
        let title: String?
        let roadAddress: String?
        let mapx: String?
        let mapy: String?
        
        public init(placeSlotId: Int?, title: String?, roadAddress: String?, mapx: String?, mapy: String?) {
            self.placeSlotId = placeSlotId
            self.title = title
            self.roadAddress = roadAddress
            self.mapx = mapx
            self.mapy = mapy
        }
    }
    
    public enum MeetStatus: String {
        case confirm = "CONFIRM"
        case beforeConfirm = "BEFORE_CONFIRM"
        case vote = "VOTE"
        case beforeVote = "BEFORE_VOTE"
    }
    
    public init(meetStatus: String?, placeInfos: [PlaceInfo]) {
        self.meetStatus = MeetStatus(rawValue: meetStatus ?? "")
        self.placeInfos = placeInfos
    }
    
}

public extension VoteLocationInfo {
    func getMeetStatus() -> MeetStatus? {
        return self.meetStatus
    }
    
    func getPlaceInfo() -> [PlaceInfo] {
        return placeInfos
    }
}

public extension VoteLocationInfo.PlaceInfo {
    func getPlaceSlotId() -> Int? {
        return placeSlotId
    }
    
    func getTitle() -> String? {
        return title
    }
    
    func getAddress() -> String? {
        return roadAddress
    }
    
    func getMapXY() -> (String?, String?) {
        return (mapx, mapy)
    }
}
