//
//  InviteReactor.swift
//  
//
//  Created by Kim Dongjoo on 8/23/24.
//

import CoreKit
import Domain

import ReactorKit

protocol InviteRouting {
    var route: PublishSubject<InviteRouter> { get }
}

enum InviteRouter {
    case back
    case detail(MeetID)
}

public final class InviteReactor: Reactor, InviteRouting {
    public enum Action {
        case viewDidAppear
        case joinButtonDidTap
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case fetchAppointmentDetail(AppointmentDetail)
        case setPopupMessage(PopupMessage)
    }
    
    public struct State {
        var details: AppointmentDetailViewModel?
        var isLoading: Bool = false
        @Pulse var popupMessage: PopupMessage?
    }
    
    public enum PopupMessage {
        case networkError(Error)
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<InviteRouter> = PublishSubject<InviteRouter>()
    
    let fetchAppointmentDetailUsecase: FetchAppointmentDetailUsecaseProtocol
    let joinAppointmentUsecase: JoinAppointmentUsecaseProtocol
    
    let meetId: MeetID
    var detail: AppointmentDetail?
    
    public init(
        id: MeetID,
        fetchAppointmentDetailUsecase: FetchAppointmentDetailUsecaseProtocol,
        joinAppointmentUsecase: JoinAppointmentUsecaseProtocol
    ) {
        self.meetId = id
        self.fetchAppointmentDetailUsecase = fetchAppointmentDetailUsecase
        self.joinAppointmentUsecase = joinAppointmentUsecase
    }
    
    // MARK: - Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidAppear:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                fetchAppointmentDetailUsecase
                    .execute(with: self.meetId)
                    .do { [weak self] detail in
                        self?.detail = detail
                    }
                    .map { Mutation.fetchAppointmentDetail($0) }
                    .asObservable()
                    .catch { error -> Observable<Mutation> in
                        return Observable.just(.setPopupMessage(.networkError(error)))
                    },
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .joinButtonDidTap:
            guard let detail = self.detail else { return .empty() }
            
            return Observable.concat([
                .just(Mutation.setLoading(true)),
                joinAppointmentUsecase
                    .execute(with: self.meetId)
                    .asObservable()
                    .flatMap { meetID -> Observable<Mutation> in
                        self.route.onNext(.detail(self.meetId))
                        return Observable.empty()
                    }
                    .catch { error -> Observable<Mutation> in
                        return Observable.just(.setPopupMessage(.networkError(error)))
                    },
                .just(.setLoading(false))
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
