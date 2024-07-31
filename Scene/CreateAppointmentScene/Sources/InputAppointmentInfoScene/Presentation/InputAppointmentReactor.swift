//
//  InputAppointmentReactor.swift
//
//
//  Created by Kim Dongjoo on 7/31/24.
//

import CoreKit

import ReactorKit

protocol InputAppointmentRouting {
    var route: PublishSubject<InputAppointmentInfoRouter> { get }
}

enum InputAppointmentInfoRouter {
    /// 뒤로 가기
    case back
    /// 테마 화면
    case theme
}

public final class InputAppointmentReactor: Reactor, InputAppointmentRouting {
    public enum Action {
        case didTapNextButton
    }
    
    public enum Mutation {
    }
    
    public struct State {
        var isLoading: Bool = false
    }
    
    public let initialState: State = State()
    let route: PublishSubject<InputAppointmentInfoRouter> = PublishSubject<InputAppointmentInfoRouter>()
    
    public init() { }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            // Routing
        case .didTapNextButton:
            route.onNext(.theme)
            return Observable.empty()
        }
    }
}
