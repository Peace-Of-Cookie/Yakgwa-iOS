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
        case didTapBackButton
        case selectTheme(Int)
    }
    
    public enum Mutation {
        case fetchThemes([Theme])
        case setTheme(Int)
        case setLoading(Bool)
        case setPopupMessage(PopupMessage)
    }
    
    public struct State {
        var isLoading: Bool = false
        var selectedTheme: Int?
        var themes: [Theme] = []
        @Pulse var popupMessage: (PopupMessage?)
    }
    
    public enum PopupMessage {
        case emptyTheme
    }
    
    // MARK: - Properties
    public let initialState: State
    let route: PublishSubject<SelectAppointmentThemeRouter> = PublishSubject<SelectAppointmentThemeRouter>()
    private let fetchThemeUseCase: FetchThemeUsecaseProtocol
    
    private var newAppointment: NewAppointment
    
    // MARK: - Initializers
    public init(
        fetchThemeUseCase: FetchThemeUsecaseProtocol,
        newAppointment: NewAppointment
    ) {
        self.fetchThemeUseCase = fetchThemeUseCase
        
        self.initialState = State()
        
        self.newAppointment = newAppointment
    }
    
    // MARK: - Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidAppear:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                fetchThemeUseCase
                    .execute()
                    .map { Mutation.fetchThemes($0) }
                    .asObservable(),
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .didTapNextButton:
            if currentState.selectedTheme == nil {
                return Observable.just(Mutation.setPopupMessage(.emptyTheme))
            }
            
            route.onNext(.date(newAppointment))
            return Observable.empty()
            
        case .didTapBackButton:
            route.onNext(.back)
            return Observable.empty()
            
        case .selectTheme(let index):
            newAppointment.setThemeId(currentState.themes[index].id)
            return Observable.just(Mutation.setTheme(index))
        }
    }
    
    // MARK: - Reduce
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .fetchThemes(let themes):
            newState.themes = themes
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .setTheme(let index):
            newState.selectedTheme = index
        case .setPopupMessage(let message):
            newState.popupMessage = message
        }
        
        return newState
    }
}
