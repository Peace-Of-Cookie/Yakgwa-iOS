//
//  HomeReactor.swift
//
//
//  Created by Ekko on 7/23/24.
//

import CoreKit

import ReactorKit

protocol HomeRouting {
    var route: PublishSubject<HomeRouter> { get }
}

enum HomeRouter {
    /// 약속 생성 화면
    case create
}

public final class HomeReactor: Reactor, HomeRouting {
    public enum Action {
        case didTapCreateAppointmentButton
    }
    
    public enum Mutation {
        case setLoading(Bool)
    }
    
    public struct State {
        var isLoading: Bool = false
    }
    
    public let initialState: State = State()
    let route: PublishSubject<HomeRouter> = PublishSubject<HomeRouter>()
    
    public init() { }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapCreateAppointmentButton:
            route.onNext(.create)
            return Observable.empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        }
        
        return newState
    }
}
