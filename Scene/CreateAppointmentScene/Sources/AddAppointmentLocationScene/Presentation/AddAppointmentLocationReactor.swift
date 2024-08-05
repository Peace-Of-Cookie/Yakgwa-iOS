//
//  InputAppointmentReactor.swift
//
//
//  Created by Kim Dongjoo on 8/5/24.
//

import CoreKit
import Domain

import ReactorKit

protocol AddAppointmentLocationRouting {
    var route: PublishSubject<AddAppointmentLocationRouter> { get }
}

enum AddAppointmentLocationRouter {
    /// 뒤로 가기
    case back
    /// 상세 화면
    case detail(Int)
}

public final class AddAppointmentLocationReactor: Reactor, AddAppointmentLocationRouting {
    public enum Action {
        case didTapCreateButton
    }
    
    public enum Mutation {
        
    }
    
    public struct State {
        var isLoading: Bool = false
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<AddAppointmentLocationRouter> = PublishSubject<AddAppointmentLocationRouter>()
    
    // MARK: - Initializers
    public init() { }
}
