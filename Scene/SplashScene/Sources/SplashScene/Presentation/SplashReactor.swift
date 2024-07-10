//
//  SplashReactor.swift
//
//
//  Created by Ekko on 7/10/24.
//

import CoreKit
import ReactorKit

public final class SplashReactor: Reactor {
    public enum Action {
        case checkIfAuthenticated
    }
    
    public enum Mutation {
        case setAutenticated(Bool)
    }
    
    public struct State {
        var isAuthenticated: Bool?
    }
    
    public var initialState = State()
    
    // TODO: Add Auth Service
    
    public init() {
        
    }
}
