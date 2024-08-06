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

public final class AddAppointmentLocationReactor: Reactor, AddAppointmentLocationRouting {
    public enum Action {
        case didTapCreateButton
        case didTapSearchButton
    }
    
    public enum Mutation {
        
    }
    
    public struct State {
        var isLoading: Bool = false
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
            route.onNext(.search)
            return Observable.empty()
        }
    }
}
