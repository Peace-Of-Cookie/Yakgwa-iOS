//
//  Participant.swift
//  
//
//  Created by Ekko on 8/15/24.
//

public struct Participant: Equatable {
    /// 역할 (Leader: 약과장, Participant: 약과원)
    let role: String?
    /// 프로필 이미지 url
    let imageUrl: String?
    /// 이름
    let name: String?
    
    public init(role: String?, imageUrl: String?, name: String?) {
        self.role = role
        self.imageUrl = imageUrl
        self.name = name
    }
}

public extension Participant {
    func getRole() -> String? {
        return role
    }
    
    func getImageUrl() -> String? {
        return imageUrl
    }
    
    func getName() -> String? {
        return name
    }
}
