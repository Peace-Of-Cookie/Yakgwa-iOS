//
//  LoginReactor.swift
//
//
//  Created by Ekko on 7/13/24.
//

import CoreKit

import ReactorKit

public final class LoginReactor: Reactor {
    public enum Action {
        case kakaoLogin
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setLoggedIn(Bool)
    }
    
    public struct State {
        var isLoading: Bool = false
        var isLoggedIn: Bool = false
    }
    
    public let initialState: State = State()
    
    fileprivate let loginUseCase: LoginUseCaseProtocol
    
    public init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .kakaoLogin:
            let setLoading: Observable<Mutation> = .just(Mutation.setLoading(true))
            let setLoggedIn: Observable<Mutation> = self.loginUseCase.kakaoLogin()
                .asObservable()
                .catchAndReturn(false)
                .map(Mutation.setLoggedIn)
            return setLoading.concat(setLoggedIn)
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .setLoggedIn(isLoggedIn):
            newState.isLoggedIn = isLoggedIn
        }
        return newState
    }
}

