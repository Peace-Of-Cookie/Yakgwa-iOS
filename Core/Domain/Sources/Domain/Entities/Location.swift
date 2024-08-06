//
//  Location.swift
//  
//
//  Created by Kim Dongjoo on 8/6/24.
//

public struct Location: Equatable {
    /// 장소 이름
    public let title: String?
    /// 링크
    public let link: String?
    /// 카테고리
    public let category: String?
    /// 전환 번호
    public let telephone: String?
    /// 주소
    public let address: String?
    /// 도로명 주소
    public let roadAddress: String?
    /// x좌표
    public let mapx: String?
    /// y좌표
    public let mapy: String?
    
    public init(title: String?, link: String?, category: String?, telephone: String?, address: String?, roadAddress: String?, mapx: String?, mapy: String?) {
        self.title = title
        self.link = link
        self.category = category
        self.telephone = telephone
        self.address = address
        self.roadAddress = roadAddress
        self.mapx = mapx
        self.mapy = mapy
    }
}
