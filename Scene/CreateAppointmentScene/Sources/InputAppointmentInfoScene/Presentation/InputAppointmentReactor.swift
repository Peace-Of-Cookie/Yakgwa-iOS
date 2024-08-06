//
//  InputAppointmentReactor.swift
//
//
//  Created by Kim Dongjoo on 7/31/24.
//

import CoreKit
import Domain

import ReactorKit

protocol InputAppointmentRouting {
    var route: PublishSubject<InputAppointmentInfoRouter> { get }
}

enum InputAppointmentInfoRouter {
    /// 뒤로 가기
    case back
    /// 테마 화면
    case theme(NewAppointment)
}

public final class InputAppointmentReactor: Reactor, InputAppointmentRouting {
    public enum Action {
        case didTapNextButton
        case updateTitle(String)
        case updateDescription(String)
    }
    
    public enum Mutation {
        case setTitle(String)
        case setDescription(String)
    }
    
    public struct State {
        var isLoading: Bool = false
        var title: String = ""
        var description: String?
    }
    
    public let initialState: State = State()
    let route: PublishSubject<InputAppointmentInfoRouter> = PublishSubject<InputAppointmentInfoRouter>()
    
    public init() { }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateTitle(let title):
            return .just(.setTitle(title))
            
        case .updateDescription(let description):
            return .just(.setDescription(description))
            
        // Routing
        case .didTapNextButton:
            let newAppointment = NewAppointment(
                title: currentState.title,
                description: currentState.description,
                date: nil
            )
            route.onNext(.theme(newAppointment))
            return Observable.empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setTitle(let title):
            newState.title = title
        case .setDescription(let description):
            newState.description = description
        }
        return newState
    }
}
