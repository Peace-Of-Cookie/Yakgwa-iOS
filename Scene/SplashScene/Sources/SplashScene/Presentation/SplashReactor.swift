//
//  SplashReactor.swift
//
//
//  Created by Ekko on 7/10/24.
//

import CoreKit
import ReactorKit

public final class SplashReactor: Reactor {
    public enum Action {
        case checkIfAuthenticated
    }
    
    public enum Mutation {
        case setAutenticated(Bool)
    }
    
    public struct State {
        var isAuthenticated: Bool?
    }
    
    public var initialState: State = State()
    
    // TODO: Add Auth Service
    
    public init() { }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .checkIfAuthenticated:
            return .just(Mutation.setAutenticated(false))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setAutenticated(inAuthenticated):
            newState.isAuthenticated = inAuthenticated
        }
        
        return newState
        
    }
}
