//
//  SelectAppointmentThemeReactor.swift
//
//
//  Created by Kim Dongjoo on 8/1/24.
//

import CoreKit

import ReactorKit
import Domain

protocol SelectAppointmentThemeRouting {
    var route: PublishSubject<SelectAppointmentThemeRouter> { get }
}

enum SelectAppointmentThemeRouter {
    /// 뒤로 가기
    case back
    /// 날짜 선택 화면
    case date(NewAppointment)
}

public final class SelectAppointmentThemeReactor: Reactor, SelectAppointmentThemeRouting {
    public enum Action {
        case viewDidAppear
        case didTapNextButton
    }
    
    public enum Mutation {
        case fetchThemes([Theme])
        case setLoading(Bool)
    }
    
    public struct State {
        var isLoading: Bool = false
        var themes: [Theme] = []
    }
    
    public let initialState: State = State()
    let route: PublishSubject<SelectAppointmentThemeRouter> = PublishSubject<SelectAppointmentThemeRouter>()
    let fetchThemeUseCase: FetchThemeUsecaseProtocol
    
    public init(fetchThemeUseCase: FetchThemeUsecaseProtocol) {
        self.fetchThemeUseCase = fetchThemeUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidAppear:
            return fetchThemeUseCase
                .execute()
                .map { Mutation.fetchThemes($0) }
                .asObservable()
            
        case .didTapNextButton:
            return Observable.empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .fetchThemes(let themes):
            newState.themes = themes
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        
        return newState
    }
}
