//
//  DateVoteReactor.swift
//
//
//  Created by Ekko on 8/24/24.
//

import Foundation

import CoreKit
import Domain

import ReactorKit

protocol DateVoteRouting {
    var route: PublishSubject<DateVoteRouter> { get }
}

enum DateVoteRouter {
    case back
    
}

public final class DateVoteReactor: Reactor, DateVoteRouting {
    public enum Action {
        case viewDidAppear
        case dateSelected(Date)
        case timeSelected(Int)
        case didTapVoteButton
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setPopupMessage(PopupMessage)
        case setDate((Date, Date))
        case selectedDate(Date)
        case setSelectedTimes(Date, [Int])
    }
    
    public struct State {
        var candidateDates: ((Date, Date))?
        var showDateTimePicker: Date? = nil
        var selectedTimes: [Date: [Int]] = [:]
        var isLoading: Bool = false
        @Pulse var popupMessage: (PopupMessage?)
    }
    
    public enum PopupMessage {
        case networkError(Error)
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<DateVoteRouter> = PublishSubject<DateVoteRouter>()
    
    // Usecase
    let voteDateUsecase: VoteDateUsecaseProtocol
    
    let meetId: MeetID
    let candidateDates: (Date, Date)
    
    public init(
        id: MeetID,
        candidateDates: (Date, Date),
        voteDateUsecase: VoteDateUsecaseProtocol
    ) {
        self.meetId = id
        self.candidateDates = candidateDates
        self.voteDateUsecase = voteDateUsecase
    }

    // MARK: - Mutation
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidAppear:
            return Observable.just(Mutation.setDate(candidateDates))
            
        case .dateSelected(let date):
            return .just(.selectedDate(date))
            
        case .timeSelected(let selectedIndex):
            guard let selectedDate = currentState.showDateTimePicker else { return .empty() }
            var times = currentState.selectedTimes[selectedDate] ?? []
            if let index = times.firstIndex(of: selectedIndex) {
                times.remove(at: index)
            } else {
                times.append(selectedIndex)
            }
            
            return .just(.setSelectedTimes(selectedDate, times))
        
        case .didTapVoteButton:
            var voteDates: [VoteDate] = []
            
            // Mapping to entity
            for (date, times) in currentState.selectedTimes {
                print("date: \(date), times: \(times)")
                for time in times {
                    if let voteDate = VoteDate(voteDate: date, times: time) {
                        voteDates.append(voteDate)
                    }
                }
            }
            
            print("투표 할 날짜: \(voteDates)")
            return Observable.concat([
                .just(.setLoading(true)),
                voteDateUsecase
                    .execute(meetId: self.meetId, with: voteDates)
                    .asObservable()
                    .flatMap { _ -> Observable<Mutation> in
                        self.route.onNext(.back)
                        return .empty()
                    }
                    .catch({ error in
                        return Observable.just(.setPopupMessage(.networkError(error)))
                    }),
                .just(.setLoading(false))
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
            
        case .setDate(let dates):
            newState.candidateDates = dates
            
        case .selectedDate(let date):
            newState.showDateTimePicker = date
            
        case .setSelectedTimes(let date, let times):
            newState.selectedTimes[date] = times
        }
        
        return newState
    }
}
