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
        case viewDidAppear
    }
    
    public enum Mutation {
        case fetchAppointments([Appointment])
        case setLoading(Bool)
    }
    
    public struct State {
        var isLoading: Bool = false
        var appointments: [Appointment] = []
    }
    
    public let initialState: State = State()
    let route: PublishSubject<HomeRouter> = PublishSubject<HomeRouter>()
    let fetchAppointmentUsecase: FetchAppointmentUsecase
    
    public init(fetchAppointmentUsecase: FetchAppointmentUsecase) {
        self.fetchAppointmentUsecase = fetchAppointmentUsecase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            // Routing
        case .didTapCreateAppointmentButton:
            route.onNext(.create)
            return Observable.empty()
        case .viewDidAppear:
            return fetchAppointmentUsecase
                .execute()
                .map { Mutation.fetchAppointments($0) }
                .asObservable()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .fetchAppointments(appointments):
            newState.appointments = appointments
        }
        
        return newState
    }
}
