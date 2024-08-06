//
//  AddCandinateLocationReactor.swift
//
//
//  Created by Kim Dongjoo on 8/6/24.
//

import CoreKit
import Domain

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
        case editQuery(String)
    }
    
    public enum Mutation {
        case editingQuery(String)
    }
    
    public struct State {
        var searchResults: [Location] = []
    }
    
    public let initialState: State = State()
    let route: PublishSubject<AddCandinateLocationRouter> = PublishSubject<AddCandinateLocationRouter>()
    
    let fetchLocationUsecase: FetchLocationsUsecaseProtocol
    
    public init(
        fetchLocationUsecase: FetchLocationsUsecaseProtocol
    ) {
        self.fetchLocationUsecase = fetchLocationUsecase
    }
}
