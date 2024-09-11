//
//  AddCandidateLocationReactor.swift
//  
//
//  Created by Kim Dongjoo on 9/11/24.
//

import CoreKit
import Domain

import ReactorKit

protocol AddCandidateLocationRouting {
    var route: PublishSubject<AddCandinateLocationRouter> { get }
}

enum AddCandinateLocationRouter {
    /// 뒤로 가기
    case back
    /// 확인
    case add([Location])
}

public enum AddCandidatePopupMessage: String, Error {
    case toomanycandidates = "장소 후보는 최대 3개까지 선택 가능해요"
    case error = "에러가 발생했어요"
}

public final class AddCandinateLocationReactor: Reactor, AddCandidateLocationRouting {
    public enum Action {
        case didTapNextButton
        case editQuery(String)
        case didTapLocationCell(Int)
    }
    
    public enum Mutation {
        case fetchLocations([Location])
        case addToCandidates(Location)
        case removeFromCandidates(Location)
        case setPopupMessage(PopupMessage)
        case setLoading(Bool)
    }
    
    public struct State {
        var isLoading: Bool = false
        var searchResultsViewModel: [LocationViewModel] = []
        @Pulse var popupMessage: (PopupMessage?)
    }
    
    public enum PopupMessage {
        case tooManyCandidates
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<AddCandinateLocationRouter> = PublishSubject<AddCandinateLocationRouter>()
    
    let fetchLocationUsecase: FetchLocationsUsecaseProtocol
    
    var searchResults: [Location] = []
    var candidateLocations: [Location] = []
    
    public init(
        fetchLocationUsecase: FetchLocationsUsecaseProtocol
    ) {
        self.fetchLocationUsecase = fetchLocationUsecase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .editQuery(let query):
            if query.isEmpty {
                return Observable.just(Mutation.setLoading(false))
            }
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                fetchLocationUsecase
                    .execute(query: query)
                    .do { self.searchResults = $0 }
                    .map { Mutation.fetchLocations($0) }
                    .asObservable(),
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .didTapNextButton:
            route.onNext(.add(candidateLocations))
            return Observable.empty()
            
        case .didTapLocationCell(let index):
            let location = searchResults[index]
            
            if let existingIndex = self.candidateLocations.firstIndex(of: location) {
                self.candidateLocations.remove(at: existingIndex)
                return Observable.just(Mutation.removeFromCandidates(location))
            }
            
            if self.candidateLocations.count >= 3 {
                return Observable.just(Mutation.setPopupMessage(.tooManyCandidates))
            }
            
            self.candidateLocations.append(location)
            return Observable.just(Mutation.addToCandidates(location))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .fetchLocations(let locations):
            newState.searchResultsViewModel = locations.map { location in
                let isSelected = candidateLocations.contains(location)
                return LocationViewModel(with: location, isSelected: isSelected)
            }
        case .addToCandidates(let location):
            newState.searchResultsViewModel = newState.searchResultsViewModel.map { viewModel in
                var viewModel = viewModel
                if viewModel.title == location.title {
                    viewModel.isSelected = true
                }
                return viewModel
            }
        case .removeFromCandidates(let location):
            newState.searchResultsViewModel = newState.searchResultsViewModel.map { viewModel in
                var viewModel = viewModel
                if viewModel.title == location.title {
                    viewModel.isSelected = false
                }
                return viewModel
            }
        case .setPopupMessage(let message):
            newState.popupMessage = message
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}

extension AddCandinateLocationReactor {
    
}


extension AddCandinateLocationReactor {
    
}

