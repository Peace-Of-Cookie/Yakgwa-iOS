//
//  AddCandinateLocationReactor.swift
//
//
//  Created by Kim Dongjoo on 8/6/24.
//

import CoreKit

import ReactorKit

protocol AddCandinateLocationRouting {
    var route: PublishSubject<AddCandinateLocationRouter> { get }
}

enum AddCandinateLocationRouter {
    /// 뒤로 가기
    case back
}

public final class AddCandinateLocationReactor: Reactor, AddCandinateLocationRouting {
    public enum Action {
        case didTapNextButton
    }
    
    public enum Mutation {
        
    }
    
    public struct State {
        
    }
    
    public let initialState: State = State()
    let route: PublishSubject<AddCandinateLocationRouter> = PublishSubject<AddCandinateLocationRouter>()
    
    public init() { }
}
