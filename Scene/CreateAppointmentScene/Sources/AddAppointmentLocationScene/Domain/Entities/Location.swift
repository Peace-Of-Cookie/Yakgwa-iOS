//
//  Location.swift
//  
//
//  Created by Kim Dongjoo on 8/5/24.
//

import Foundation

public struct Location: Equatable {
    /// 장소 이름
    let title: String?
    /// 링크
    let link: String?
    /// 카테고리
    let category: String?
    /// 전환 번호
    let telephone: String?
    /// 주소
    let address: String?
    /// 도로명 주소
    let roadAddress: String?
    /// x좌표
    let mapx: String?
    /// y좌표
    let mapy: String?
}
