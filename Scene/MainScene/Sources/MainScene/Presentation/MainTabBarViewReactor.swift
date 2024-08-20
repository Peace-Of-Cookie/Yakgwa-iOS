//
//  MainTabBarViewReactor.swift
//  
//
//  Created by Kim Dongjoo on 7/12/24.
//

import ReactorKit
import RxSwift

protocol MainTabBarRouting {
    var route: PublishSubject<MainTabBarRouter> { get }
}

enum MainTabBarRouter {
    case createAppointment
}

public final class MainTabBarViewReactor: Reactor {
    public enum Action {
        case didTapCreateButton
    }

    public struct State {
    }

    // MARK: - Properties
    public let initialState: State = State()
    let route : PublishSubject<MainTabBarRouter> = PublishSubject<MainTabBarRouter>()
    
    // MARK: - Initializers
    public init() {
        
    }
    
    public func mutate(action: Action) -> Observable<Action> {
        switch action {
        case .didTapCreateButton:
            print("Reactor: .didTapCreateButton")
            route.onNext(.createAppointment)
            return Observable.empty()
        }
    }
}
