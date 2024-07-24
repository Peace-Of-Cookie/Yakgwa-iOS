//
//  Appointment.swift
//
//
//  Created by Ekko on 7/12/24.
//

import Foundation

/// 모임 정보 엔터티 (상세 정보 X)
public struct Appointment: Equatable{
    /// 현재 상태
    let status: String?
    /// 테마
    let theme: String?
    /// 시간
    let dateTime: String?
    /// 장소
    let location: String?
    /// 제목
    let title: String?
    /// ID
    let id: Int
}
