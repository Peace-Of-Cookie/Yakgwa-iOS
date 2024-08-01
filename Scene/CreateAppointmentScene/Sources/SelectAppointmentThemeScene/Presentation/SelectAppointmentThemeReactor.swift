//
//  SelectAppointmentThemeReactor.swift
//
//
//  Created by Kim Dongjoo on 8/1/24.
//

import CoreKit

import ReactorKit
import Domain

protocol SelectAppointmentThemeRouting {
    var route: PublishSubject<SelectAppointmentThemeRouter> { get }
}

enum SelectAppointmentThemeRouter {
    /// 뒤로 가기
    case back
    /// 날짜 선택 화면
    case date(NewAppointment)
}
