//
//  InputAppointmentReactor.swift
//
//
//  Created by Kim Dongjoo on 8/5/24.
//

import CoreKit
import Domain

import ReactorKit

protocol AddAppointmentLocationRouting {
    var route: PublishSubject<AddAppointmentLocationRouter> { get }
}

enum AddAppointmentLocationRouter {
    /// 뒤로 가기
    case back
    /// 상세 화면
    case detail(Int)
    /// 검색 화면
    case search
}

public enum AddLocationPopupMessage: String, Error {
    case toomanycandidates = "장소 후보는 최대 3개까지 선택 가능해요"
    case error = "에러가 발생했어요"
}

public final class AddAppointmentLocationReactor: Reactor, AddAppointmentLocationRouting {
    public enum Action {
        case didTapCreateButton
        case didTapSearchButton
        case returnToScene([Location])
    }
    
    public enum Mutation {
        case addToCandidates([LocationViewModel])
        case showPopUp(AddLocationPopupMessage)
    }
    
    public struct State {
        var isLoading: Bool = false
        var locations: [LocationViewModel] = []
        var showPopup: AddLocationPopupMessage? = nil
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<AddAppointmentLocationRouter> = PublishSubject<AddAppointmentLocationRouter>()
    
    private var newAppointment: NewAppointment
    
    // MARK: - Initializers
    public init(
        newAppointment: NewAppointment
    ) {
        self.newAppointment = newAppointment
    }
    
    // MARK: - Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapCreateButton:
            route.onNext(.detail(0))
            return Observable.empty()
        case .didTapSearchButton:
            if currentState.locations.count > 3 {
                return Observable.just(.showPopUp(.toomanycandidates))
            }
            route.onNext(.search)
            return Observable.empty()
        case .returnToScene(let locations):
            return Observable.just(.addToCandidates(locations.map { LocationViewModel(with: $0) }))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .addToCandidates(let locations):
            newState.locations.append(contentsOf: locations)
        case .showPopUp(let message):
            newState.showPopup = message
        }
        
        return newState
    }
}
