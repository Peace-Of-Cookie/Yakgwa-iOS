//
//  LocationCandidate.swift
//
//
//  Created by Ekko on 8/24/24.
//

public struct LocationCandidate: Equatable {
    /// 후보지 id
    public let id: String
    /// 장소 이름
    public let title: String
    /// 주소
    public let address: String
    /// 투표자 정보
    public let userInfo: [Participant]
    
    public init(id: String, title: String, address: String, userInfo: [Participant]) {
        self.id = id
        self.title = title
        self.address = address
        self.userInfo = userInfo
    }
}

public extension LocationCandidate {
    func getId() -> String {
        return id
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getAddress() -> String {
        return address
    }
    
    func getUserInfo() -> [Participant] {
        return userInfo
    }
}
