//
//  AppointmentDetailViewReactor.swift
//
//
//  Created by Ekko on 8/15/24.
//

import CoreKit
import Domain

import ReactorKit

import KakaoSDKTemplate
import SafariServices
import KakaoSDKShare
import KakaoSDKCommon

protocol AppointmentDetailViewRouting {
    var route: PublishSubject<AppointmentDetailRouter> { get }
}

enum AppointmentDetailRouter {
    case back
    case dateVote(MeetID, (Date, Date))
    case locationVote(MeetID)
}

public final class AppointmentDetailViewReactor: Reactor, AppointmentDetailViewRouting {
    public enum Action {
        case viewDidAppear
        case didTapInviteButton
        case didTapDateVoteButton
        case didTapLocationVoteButton
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case fetchAppointmentDetail(AppointmentDetail)
        case fetchMyVoteLocations(VoteLocationInfo)
        case fetchMyVoteDates(VoteDateInfo)
        case setPopupMessage(PopupMessage)
    }
    
    public struct State {
        var details: AppointmentDetailViewModel?
        var locationVoteInfo: VoteLocationInfo?
        var dateVoteInfo: VoteDateInfo?
        var showLocationVoteInfo: Bool = false
        var showDateVoteInfo: Bool = false
        var voted: Bool = false
        var dateVoteStatus: MeetStatus?
        var locationVoteStatus: MeetStatus?
        var isLoading: Bool = false
        @Pulse var popupMessage: (PopupMessage?)
    }
    
    public enum PopupMessage {
        case networkError(Error)
    }
    
    // MARK: - Properties
    public let initialState: State = State()
    let route: PublishSubject<AppointmentDetailRouter> = PublishSubject<AppointmentDetailRouter>()
    
    let fetchAppointmentDetailUsecase: FetchAppointmentDetailUsecaseProtocol
    let fetchMyVoteLocationsUsecase: FetchMyVoteLocationsUsecaseProtocol
    let fetchDateCandidatesUsecase: FetchDateCandidatesUsecaseProtocol
    
    let meetId: MeetID
    var detail: AppointmentDetail?
    var candidateDate: (Date, Date)?
    
    public init(
        id: MeetID,
        fetchAppointmentDetailUsecase: FetchAppointmentDetailUsecaseProtocol,
        fetchMyVoteLocationsUsecase: FetchMyVoteLocationsUsecaseProtocol,
        fetchDateCandidatesUsecase: FetchDateCandidatesUsecaseProtocol
    ) {
        self.meetId = id
        self.fetchAppointmentDetailUsecase = fetchAppointmentDetailUsecase
        self.fetchMyVoteLocationsUsecase = fetchMyVoteLocationsUsecase
        self.fetchDateCandidatesUsecase = fetchDateCandidatesUsecase
    }
    
    // MARK: - Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidAppear:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                fetchAppointmentDetailUsecase
                    .execute(with: self.meetId)
                    .do { [weak self] detail in
                        print("약속 상세 정보(\(self?.meetId.getMeetId())):  \(detail)")
                        self?.detail = detail
                    }
                    .map { Mutation.fetchAppointmentDetail($0) }
                    .asObservable()
                    .catch { error -> Observable<Mutation> in
                        return Observable.just(.setPopupMessage(.networkError(error)))
                    },
                fetchMyVoteLocationsUsecase
                    .execute(with: self.meetId)
                    .map { Mutation.fetchMyVoteLocations($0) }
                    .asObservable()
                    .catch { error -> Observable<Mutation> in
                        return Observable.just(.setPopupMessage(.networkError(error)))
                    },
                fetchDateCandidatesUsecase
                    .execute(with: self.meetId)
                    .do { [weak self] result in
                        self?.candidateDate = result.getCandidateDate()
                    }
                    .map { Mutation.fetchMyVoteDates($0) }
                    .asObservable()
                    .catch { error -> Observable<Mutation> in
                        return Observable.just(.setPopupMessage(.networkError(error)))
                    },
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .didTapInviteButton:
            self.sendKakaoMessageWithFeedTemplate()
            return .empty()
            
        case .didTapDateVoteButton:
            if let candidateDate = candidateDate {
                route.onNext(.dateVote(meetId, candidateDate))
            }
            return .empty()
            
        case .didTapLocationVoteButton:
            route.onNext(.locationVote(meetId))
            return .empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .fetchAppointmentDetail(let detail):
            newState.details = AppointmentDetailViewModel(with: detail)
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .setPopupMessage(let message):
            newState.popupMessage = message
            
        case .fetchMyVoteLocations(let info):
            newState.locationVoteInfo = info
            newState.showLocationVoteInfo = info.getCount() > 0
            newState.locationVoteStatus = info.getMeetStatus()
            
        case .fetchMyVoteDates(let info):
            newState.dateVoteInfo = info
            newState.showDateVoteInfo = info.getTimeInfoCount() > 0
            newState.dateVoteStatus = info.getMeetStatus()
        }
        
        if let locationVoteInfo = newState.locationVoteInfo,
           let dateVoteInfo = newState.dateVoteInfo,
           locationVoteInfo.getCount() > 0,
           dateVoteInfo.getTimeInfoCount() > 0 {
            newState.voted = true
        } else {
            newState.voted = false
        }
        
        return newState
    }
}

extension AppointmentDetailViewReactor {
    private func sendKakaoMessageWithFeedTemplate() {
        let template = createFeedTemplate()
        if let feedTemplateJsonData = (try? SdkJSONEncoder.custom.encode(template)) {
            if let templateJsonObject = SdkUtils.toJsonObject(feedTemplateJsonData) {
                ShareApi.shared.shareDefault(templateObject: templateJsonObject) {(sharingResult, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("shareDefault() success.")
                        
                        //do something
                        guard let sharingResult = sharingResult else { return }
                        UIApplication.shared.open(sharingResult.url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    private func createFeedTemplate() -> FeedTemplate {
        let appLink = Link(androidExecutionParams: ["inviteId": "\(meetId.getMeetId())"],
                           iosExecutionParams: ["inviteId": "\(meetId.getMeetId())"])
        let button = Button(title: "앱으로 보기", link: appLink)
        
        let content = Content(title: "\(detail?.getTitle() ?? "")",
                              imageUrl: URL(string: "http://k.kakaocdn.net/dn/bp2Qmz/btsHbRn5Auu/I4MY1Ks8YoU2npkzSr7WT0/kakaolink40_original.png"), 
                              description: "\(detail?.getDescription() ?? "")",
                              link: appLink)
        return FeedTemplate(
            content: content,
            buttons: [button]
        )
    }
}
