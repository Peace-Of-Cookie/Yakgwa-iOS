//
//  DateVoteReactor.swift
//
//
//  Created by Ekko on 8/24/24.
//

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
        
    }
    
    public enum Mutation {
        
    }
    
    public struct State {
        
    }
    
    public enum PopupMessage {
        case networkError(Error)
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<DateVoteRouter> = PublishSubject<DateVoteRouter>()
    
    let meetId: MeetID
    
    public init(
        id: MeetID
    ) {
        self.meetId = id
    }
}
