//
//  UserInfo.swift
//  Domain
//
//  Created by Kim Dongjoo on 9/23/24.
//

public struct UserInfo: Equatable {
    let name: String
    let imageUrl: String
    
    public init(name: String, imageUrl: String) {
        self.name = name
        self.imageUrl = imageUrl
    }
}

extension UserInfo {
    public func getName() -> String {
        return name
    }
    
    public func getImageUrl() -> String {
        return imageUrl
    }
}
