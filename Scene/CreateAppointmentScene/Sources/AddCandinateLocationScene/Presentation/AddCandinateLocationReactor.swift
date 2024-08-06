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
        case fetchLocations([Location])
    }
    
    public struct State {
        var searchResults: [LocationViewModel] = []
    }
    
    public let initialState: State = State()
    let route: PublishSubject<AddCandinateLocationRouter> = PublishSubject<AddCandinateLocationRouter>()
    
    let fetchLocationUsecase: FetchLocationsUsecaseProtocol
    
    public init(
        fetchLocationUsecase: FetchLocationsUsecaseProtocol
    ) {
        self.fetchLocationUsecase = fetchLocationUsecase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .editQuery(let query):
            return fetchLocationUsecase
                .execute(query: query)
                .map { Mutation.fetchLocations($0) }
                .asObservable()
        case .didTapNextButton:
            route.onNext(.back)
            return Observable.empty()

        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .fetchLocations(let locations):
            let viewModel = locations.map { LocationViewModel(with: $0) }
            newState.searchResults = viewModel
        }
        return newState
    }
}
