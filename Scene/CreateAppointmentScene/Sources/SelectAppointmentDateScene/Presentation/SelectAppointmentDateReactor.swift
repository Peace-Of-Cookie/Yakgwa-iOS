//
//  SelectAppointmentDateReactor.swift
//
//
//  Created by Kim Dongjoo on 8/2/24.
//

import CoreKit

import ReactorKit
import Domain
import Foundation

protocol SelectAppointmentDateRouting {
    var route: PublishSubject<SelectAppointmentDateRouter> { get }
}

enum SelectAppointmentDateRouter {
    /// 뒤로 가기
    case back
    /// 장소 선택 화면
    case location(NewAppointment)
}

public final class SelectAppointmentDateReactor: Reactor,SelectAppointmentDateRouting {
    
    public enum Action {
        case selectDateRange(Set<ClosedRange<Date>>?)
        case changeMode(YakgwaSwitchViewState)
        case didTapDateInputField(PickerSheetType)
        case setAppointmentDate(Date)
        case setAppointmentTime(Date)
        case didTapNextButton
        case didTapBackButton
    }
    
    public enum Mutation {
        case updateDateRange(Set<ClosedRange<Date>>?)
        case updateMode(YakgwaSwitchViewState)
        case showPickerSheet(PickerSheetType)
        case setPopupMessage(PopupMessage)
    }
    
    public struct State { 
        var mode: YakgwaSwitchViewState = .first
        @Pulse var pickerSheetShown: PickerSheetType?
        @Pulse var popupMessage: (PopupMessage?)
    }
    
    public enum PopupMessage {
        /// 날짜 선택 안됨
        case emptyDate
        /// 2주 초과
        case expandRange
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<SelectAppointmentDateRouter> = PublishSubject<SelectAppointmentDateRouter>()
    
    private var newAppointment: NewAppointment
    
    public init(
        newAppointment: NewAppointment
    ) {
        self.newAppointment = newAppointment
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectDateRange(let dateRange):
            guard let dateRange = dateRange else { return .empty() }
            guard let startDate = dateRange.first?.lowerBound else { return .empty() }
            guard let endDate = dateRange.first?.upperBound else { return .empty() }
            
            let diff = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
            if diff > 14 {
                newAppointment.setDateToDirectInput()
                return .just(.setPopupMessage(.expandRange))
            }
            
            newAppointment.setVoteDate(startDate: startDate, endDate: endDate)
            return .empty()
        
        case .changeMode(let mode):
            if mode == .first {
                // 투표 후보 입력 모드
                newAppointment.setDateToVote()
            } else {
                // 직접 입력 모드
                newAppointment.setDateToDirectInput()
            }
            return .just(.updateMode(mode))

        case .didTapDateInputField(let type):
            return .just(.showPickerSheet(type))
            
        case .setAppointmentDate(let date):
            newAppointment.setDate(date)
            return .empty()
        
        case .setAppointmentTime(let time):
            newAppointment.setTime(time)
            return .empty()
            
        case .didTapNextButton:
            print("엔터티: \(newAppointment)")
            if currentState.mode == .first {
                if newAppointment.getStartDate() == nil || newAppointment.getEndDate() == nil {
                    return .just(.setPopupMessage(.emptyDate))
                }
            } else {
                if newAppointment.getDate() == nil || newAppointment.getTime() == nil  {
                    return .just(.setPopupMessage(.emptyDate))
                }
            }
            
            route.onNext(.location(newAppointment))
            return Observable.empty()
            
        case .didTapBackButton:
            route.onNext(.back)
            return Observable.empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateMode(let mode):
            newState.mode = mode
        case .showPickerSheet(let type):
            newState.pickerSheetShown = type
        case .setPopupMessage(let message):
            newState.popupMessage = message
        default:
            break
        }
        
        return newState
    }
}
