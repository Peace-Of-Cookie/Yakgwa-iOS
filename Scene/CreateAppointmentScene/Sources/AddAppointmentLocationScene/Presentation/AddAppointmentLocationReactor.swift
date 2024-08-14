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
    case detail(MeetID)
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
        case editQuery(String)
        case didTapLocationCell(Int)
        case returnToScene([Location])
        case changeMode(YakgwaSwitchViewState)
    }
    
    public enum Mutation {
        case addToCandidates([LocationViewModel])
        case clearCandindates
        case fetchLocations([Location])
        case updateLocations(Location)
        case showPopUp(AddLocationPopupMessage)
        case updateMode(YakgwaSwitchViewState)
    }
    
    public struct State {
        var mode: YakgwaSwitchViewState = .first
        var isLoading: Bool = false
        var locations: [LocationViewModel] = []
        var searchResults: [LocationViewModel] = []
        var showPopup: AddLocationPopupMessage? = nil
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<AddAppointmentLocationRouter> = PublishSubject<AddAppointmentLocationRouter>()
    
    private var newAppointment: NewAppointment
    private var fetchLocationUsecase: FetchLocationsUsecaseProtocol
    private var createAppointmentUsecase: CreateAppointmentUsecaseProtocol
    
    var searchResults: [Location] = []
    var selectedLocation: Location?
    
    // MARK: - Initializers
    public init(
        newAppointment: NewAppointment,
        fetchLocationUsecase: FetchLocationsUsecaseProtocol,
        createAppointmentUsecase: CreateAppointmentUsecaseProtocol
    ) {
        self.newAppointment = newAppointment
        self.fetchLocationUsecase = fetchLocationUsecase
        self.createAppointmentUsecase = createAppointmentUsecase
    }
    
    // MARK: - Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapCreateButton:
            return createAppointmentUsecase
                .execute(appointment: self.newAppointment)
                .asObservable()
                .flatMap { meetID -> Observable<Mutation> in
                    self.route.onNext(.detail(meetID))
                    return Observable.empty()
                }
                .catch { error in
                    print("에러 발생:\(error.localizedDescription)")
                    return Observable.just(.showPopUp(.error))
                }
                
                
        case .didTapSearchButton:
            if currentState.locations.count > 3 {
                return Observable.just(.showPopUp(.toomanycandidates))
            }
            route.onNext(.search)
            return Observable.empty()
            
        case .editQuery(let query):
            return fetchLocationUsecase
                .execute(query: query)
                .asObservable()
                .flatMap { [weak self] newResults -> Observable<Mutation> in
                    guard let self = self else { return Observable.empty() }
                    
                    // 이전 결과와 새 결과 비교
                    if self.searchResults == newResults {
                        return Observable.empty() // 동일하면 무시
                    }
                    
                    // 새 결과 저장
                    self.searchResults = newResults
                    
                    // Mutation 반환
                    return Observable.just(.fetchLocations(newResults))
                }
            
        case .returnToScene(let locations):
            self.newAppointment.setCandicdateLocations(locations)
            return Observable.just(.addToCandidates(locations.map { LocationViewModel(with: $0) }))
            
        case .didTapLocationCell(let index):
            let selectedLocation = searchResults[index]
            self.selectedLocation = selectedLocation
            
            // Configure Entity
            newAppointment.setLocation(selectedLocation)
            
            return Observable.just(.updateLocations(selectedLocation))
            
        case .changeMode(let mode):
            if mode == .first {
                newAppointment.setLocationToVote()
            } else {
                newAppointment.setLocationToDirectInput()
            }
            
            return Observable.concat([
                .just(.updateMode(mode)),
                .just(.clearCandindates)
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .addToCandidates(let locations):
            newState.locations.append(contentsOf: locations)
            
        case .clearCandindates:
            newState.locations = []
            
        case .fetchLocations(let locations):
            self.selectedLocation = nil
            newState.searchResults = locations.map { LocationViewModel(with: $0) }
            
        case .showPopUp(let message):
            newState.showPopup = message
            
        case .updateLocations(let location):
            newState.searchResults = newState.searchResults.map { viewModel in
                var updatedViewModel = viewModel
                // 선택된 location에 대한 ViewModel의 isSelected를 true로 설정하고, 나머지는 false로 설정
                if viewModel.title == location.title && ((viewModel.address == location.address) || (viewModel.address == location.roadAddress))  {
                    updatedViewModel.isSelected = true
                } else {
                    updatedViewModel.isSelected = false
                }
                return updatedViewModel
            }
        
        case .updateMode(let mode):
            newState.searchResults = []
            newState.mode = mode
        }
        
        return newState
    }
}
