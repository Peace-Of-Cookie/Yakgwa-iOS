//
//  HomeReactor.swift
//
//
//  Created by Ekko on 7/23/24.
//

import CoreKit

import ReactorKit
import Domain

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
        case viewDidAppear
    }
    
    public enum Mutation {
        case fetchAppointments([AppointmentDetail])
        case setLoading(Bool)
        case setPopupMessage(PopupMessage)

    }
    
    public struct State {
        var isLoading: Bool = false
        var appointments: [AppointmentDetail] = []
        @Pulse var popupMessage: (PopupMessage?)

    }
    
    public enum PopupMessage {
        case networkError(Error)
    }
    
    public let initialState: State = State()
    let route: PublishSubject<HomeRouter> = PublishSubject<HomeRouter>()
    let fetchAppointmentUsecase: FetchCurrentAppointmentsUsecaseProtocol
    
    public init(fetchAppointmentUsecase: FetchCurrentAppointmentsUsecaseProtocol) {
        self.fetchAppointmentUsecase = fetchAppointmentUsecase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            // Routing
        case .didTapCreateAppointmentButton:
            route.onNext(.create)
            return Observable.empty()
            
        case .viewDidAppear:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                fetchAppointmentUsecase
                    .execute()
                    .map { Mutation.fetchAppointments($0) }
                    .asObservable()
                    .catch { error in
                            .just(.setPopupMessage(.networkError(error)))
                    },
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
            
        case let .fetchAppointments(appointments):
            newState.appointments = appointments
            
        case .setPopupMessage(let message):
            newState.popupMessage = message
        }
        
        return newState
    }
}
