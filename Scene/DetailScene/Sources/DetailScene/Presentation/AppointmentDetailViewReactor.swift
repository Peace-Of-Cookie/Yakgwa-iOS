//
//  AppointmentDetailViewReactor.swift
//
//
//  Created by Ekko on 8/15/24.
//

import CoreKit
import Domain

import ReactorKit

protocol AppointmentDetailViewRouting {
    var route: PublishSubject<AppointmentDetailRouter> { get }
}

enum AppointmentDetailRouter {
    case back
}

public final class AppointmentDetailViewReactor: Reactor, AppointmentDetailViewRouting {
    public enum Action {
        case viewDidAppear
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case fetchAppointmentDetail(AppointmentDetail)
        case setPopupMessage(PopupMessage)
    }
    
    public struct State {
        var details: AppointmentDetailViewModel?
        var isLoading: Bool = false
        @Pulse var popupMessage: (PopupMessage?)
    }
    
    public enum PopupMessage {
        case networkError(Error)
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<AppointmentDetailRouter> = PublishSubject<AppointmentDetailRouter>()
    
    let fetchAppointmentDetailUsecase: FetchAppointmentDetailUsecaseProtocol
    
    let meetId: MeetID
    
    public init(
        id: MeetID,
        fetchAppointmentDetailUsecase: FetchAppointmentDetailUsecaseProtocol
    ) {
        self.meetId = id
        self.fetchAppointmentDetailUsecase = fetchAppointmentDetailUsecase
    }
    
    // MARK: - Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidAppear:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                fetchAppointmentDetailUsecase
                    .execute(with: self.meetId)
                    .map { Mutation.fetchAppointmentDetail($0) }
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
        case .fetchAppointmentDetail(let detail):
            newState.details = AppointmentDetailViewModel(with: detail)
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .setPopupMessage(let message):
            newState.popupMessage = message
        }
        
        return newState
    }
}
