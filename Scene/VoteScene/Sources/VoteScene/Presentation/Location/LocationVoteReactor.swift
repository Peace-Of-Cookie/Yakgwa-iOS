//
//  LocationVoteReactor.swift
//
//
//  Created by Ekko on 8/24/24.
//

import CoreKit
import Domain

import ReactorKit

protocol LocationVoteRouting {
    var route: PublishSubject<LocationVoteRouter> { get }
}

enum LocationVoteRouter {
    case back
    case addCandindate
}

public final class LocationVoteReactor: Reactor, LocationVoteRouting {
    public enum Action {
        case viewDidAppear
        case addCondidateButtonDidTap
        case voteButtonDidTap
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case fetchLocationCandidate([LocationCandidate])
        case setPopupMessage(PopupMessage)
    }
    
    public struct State {
        var candidates: [CandidateViewModel] = []
        var isLoading: Bool = false
        @Pulse var popupMessage: (PopupMessage?)
    }
    
    public enum PopupMessage {
        case networkError(Error)
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<LocationVoteRouter> = PublishSubject<LocationVoteRouter>()
    
    // Usecases
    let fetchLocationCandidateUsecase: FetchLocationCandidateUsecaseProtocol
    
    let meetId: MeetID
    var candidates: [LocationCandidate] = []
    
    public init(
        id: MeetID,
        fetchLocationCandidateUsecase: FetchLocationCandidateUsecaseProtocol
    ) {
        self.meetId = id
        self.fetchLocationCandidateUsecase = fetchLocationCandidateUsecase
    }
    
    // MARK: - Mutation
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidAppear:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                fetchLocationCandidateUsecase
                    .execute(with: self.meetId)
                    .do { [weak self] result in
                        print("후보지: \(result)")
                        self?.candidates = result
                    }
                    .map { Mutation.fetchLocationCandidate($0) }
                    .asObservable()
                    .catch { error -> Observable<Mutation> in
                        return Observable.just(.setPopupMessage(.networkError(error)))
                    },
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .addCondidateButtonDidTap:
            self.route.onNext(.addCandindate)
            return .empty()
            
        case .voteButtonDidTap:
            return .empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .fetchLocationCandidate(let candidates):
            newState.candidates = candidates.map { CandidateViewModel(with: $0) }
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .setPopupMessage(let message):
            newState.popupMessage = message
        }
        
        return newState
    }
}
