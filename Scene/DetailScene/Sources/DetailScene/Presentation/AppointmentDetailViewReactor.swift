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
        
    }
    
    public enum Mutation {
        
    }
    
    public struct State {
        
    }
    
    public enum PopupMessage {
        
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<AppointmentDetailRouter> = PublishSubject<AppointmentDetailRouter>()
    
    let meetId: MeetID
    
    public init(id: MeetID) {
        self.meetId = id
    }
}
