//
//  SelectAppointmentDateReactor.swift
//
//
//  Created by Kim Dongjoo on 8/2/24.
//

import CoreKit

import ReactorKit
import Domain

protocol SelectAppointmentDateRouting {
    var route: PublishSubject<SelectAppointmentDateRouter> { get }
}

enum SelectAppointmentDateRouter {
    /// 뒤로 가기
    case back
    /// 장소 선택 화면
    case location(NewAppointment)
}

public final class SelectAppointmentDateReactor: Reactor,SelectAppointmentDateRouting {
    
    
    public enum Action {
        
    }
    
    public enum Mutation {
        
    }
    
    public struct State { 
        
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<SelectAppointmentDateRouter> = PublishSubject<SelectAppointmentDateRouter>()
    
    private var newAppointment: NewAppointment
    
    public init(
        newAppointment: NewAppointment
    ) {
        self.newAppointment = newAppointment
    }
}
