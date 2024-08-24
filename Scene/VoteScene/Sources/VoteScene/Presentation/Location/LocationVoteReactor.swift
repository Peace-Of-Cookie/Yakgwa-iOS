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
    let route: PublishSubject<LocationVoteRouter> = PublishSubject<LocationVoteRouter>()
    
    let meetId: MeetID
    
    public init(
        id: MeetID
    ) {
        self.meetId = id
    }
}
