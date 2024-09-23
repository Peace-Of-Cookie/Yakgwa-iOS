//
//  MyPageReactor.swift
//  MyPageScene
//
//  Created by Kim Dongjoo on 9/23/24.
//

import CoreKit
import Domain

import ReactorKit

protocol MyPageRouting {
    var route: PublishSubject<MyPageRouter> { get }
}

enum MyPageRouter {
    
}

public final class MyPageReactor: Reactor, MyPageRouting {
    public enum Action {
        case viewDidAppear
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setPopupMessage(PopupMessage)
        case fetchUserInfo(UserInfo)
    }
    
    public struct State {
        var isLoading: Bool = false
        @Pulse var popupMessage: (PopupMessage?)
        var userInfo: UserInfo?
    }
    
    public enum PopupMessage {
        case networkError(Error)
    }
    
    // MARK: - Properties
    public var initialState: State = State()
    var route: PublishSubject<MyPageRouter> = PublishSubject<MyPageRouter>()
    
    // Usecase
    let fetchUserInfoUsecase: FetchUserInfoUsecaseProtocol
    
    // MARK: - Initializers
    public init(
        fetchUserInfoUsecase: FetchUserInfoUsecaseProtocol
    ) {
        self.fetchUserInfoUsecase = fetchUserInfoUsecase
    }
    
    // MARK: - Mutaion
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidAppear:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                fetchUserInfoUsecase
                    .execute()
                    .map { Mutation.fetchUserInfo($0) }
                    .asObservable()
                    .catch { error -> Observable<Mutation> in
                        return Observable.just(.setPopupMessage(.networkError(error)))
                    },
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .setPopupMessage(let message):
            newState.popupMessage = message
        case .fetchUserInfo(let userInfo):
            newState.userInfo = userInfo
        }
        return newState
    }
}
