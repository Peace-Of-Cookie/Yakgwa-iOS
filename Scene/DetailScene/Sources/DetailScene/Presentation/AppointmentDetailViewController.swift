//
//  AppointmentDetailViewController.swift
//
//
//  Created by Ekko on 7/19/24.
//

import UIKit

import CoreKit
import ReactorKit
import Domain
import RxCocoa

public final class AppointmentDetailViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    var sendRoutingEvent: ((AppointmentDetailRouter) -> Void)?
    
    // MARK: - UI Components
    private lazy var navigationBar: YakgwaNavigationDetailBar = {
        let nav = YakgwaNavigationDetailBar()
        nav.delegate = self
        nav.configure(previousTitle: "약과장의 약과모임")
        return nav
    }()
    
    private lazy var bottomSheetButton: BottomSheetButton = {
        let button = BottomSheetButton(title: "시간 및 장소 투표하기")
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var appointmentDetailView: DefaultAppointmentView = {
        let view = DefaultAppointmentView()
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .neutralBlack
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var popupView: YakgwaPopUpView = {
        let view = YakgwaPopUpView()
        view.isHidden = true
        return view
    }()
    
    private lazy var voteStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    private lazy var dateVoteView: VoteView = {
        let view = VoteView()
        view.configure(type: .date)
        return view
    }()
    
    private lazy var locationVoteView: VoteView = {
        let view = VoteView()
        view.configure(type: .location)
        return view
    }()
    
    private lazy var myVotedDateView: MyVotedDateView = {
        let view = MyVotedDateView()
        return view
    }()
    
    private lazy var myVotedLocationView: MyVotedLocationView = {
        let view = MyVotedLocationView()
        return view
    }()
    
    // MARK: - Initializers
    public init(
        reactor: AppointmentDetailViewReactor
    ) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Privates
    private func setUI() {
        self.view.backgroundColor = .neutral200
        
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.view.addSubview(bottomSheetButton)
        bottomSheetButton.snp.makeConstraints {
            $0.height.equalTo(92)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomSheetButton.snp.top)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        self.contentView.addSubview(appointmentDetailView)
        appointmentDetailView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.contentView.addSubview(voteStack)
        voteStack.snp.makeConstraints {
            $0.top.equalTo(appointmentDetailView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        voteStack.addArrangedSubview(dateVoteView)
        voteStack.addArrangedSubview(locationVoteView)
        
        self.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.view.addSubview(popupView)
        popupView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    public func bind(reactor: AppointmentDetailViewReactor) {
        // Action
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.appointmentDetailView.inviteButton.rx.tap
            .map { Reactor.Action.didTapInviteButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.dateVoteView.voteButton.rx.tap
            .map { Reactor.Action.didTapDateVoteButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        self.locationVoteView.voteButton.rx.tap
            .map { Reactor.Action.didTapLocationVoteButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .compactMap { $0.details }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] detail in
                self?.appointmentDetailView.configure(with: detail)
            })
            .disposed(by: disposeBag)
        
        // DateVoteInfo에 따른 뷰 교체
        reactor.state.map { $0.showDateVoteInfo }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] showDateVoteInfo in
                guard let self = self else { return }
                if showDateVoteInfo {
                    // myVotedDateView를 보여줌
                    if self.voteStack.arrangedSubviews.contains(self.dateVoteView) {
                        self.voteStack.removeArrangedSubview(self.dateVoteView)
                        self.dateVoteView.removeFromSuperview()
                        self.voteStack.insertArrangedSubview(self.myVotedDateView, at: 0)
                    }
                } else {
                    // dateVoteView를 보여줌
                    if self.voteStack.arrangedSubviews.contains(self.myVotedDateView) {
                        self.voteStack.removeArrangedSubview(self.myVotedDateView)
                        self.myVotedDateView.removeFromSuperview()
                        self.voteStack.insertArrangedSubview(self.dateVoteView, at: 0)
                    }
                }
            })
            .disposed(by: disposeBag)
            
            // LocationVoteInfo에 따른 뷰 교체
            reactor.state.map { $0.showLocationVoteInfo }
                .distinctUntilChanged()
                .subscribe(onNext: { [weak self] showLocationVoteInfo in
                    guard let self = self else { return }
                    if showLocationVoteInfo {
                        // myVotedLocationView를 보여줌
                        if self.voteStack.arrangedSubviews.contains(self.locationVoteView) {
                            self.voteStack.removeArrangedSubview(self.locationVoteView)
                            self.locationVoteView.removeFromSuperview()
                            self.voteStack.insertArrangedSubview(self.myVotedLocationView, at: 1)
                        }
                    } else {
                        // locationVoteView를 보여줌
                        if self.voteStack.arrangedSubviews.contains(self.myVotedLocationView) {
                            self.voteStack.removeArrangedSubview(self.myVotedLocationView)
                            self.myVotedLocationView.removeFromSuperview()
                            self.voteStack.insertArrangedSubview(self.locationVoteView, at: 1)
                        }
                    }
                })
                .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.locationVoteInfo }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] info in
                print("투표 정보 \(info)")
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.dateVoteInfo }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] info in
                self?.myVotedDateView.configure(with: info)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$popupMessage)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] message in
                self?.popupView.isHidden = false
                switch message {
                case .networkError(let error):
                    self?.popupView.configure(
                        description: error.localizedDescription,
                        firstButtonTitle: "닫기"
                    )
                    
                    self?.popupView.didTapFisrtButton(completion: {
                        self?.popupView.isHidden = true
                    })
                }
            })
            .disposed(by: disposeBag)
        
        // Routing
        reactor.route
            .subscribe(onNext: { [weak self] router in
                self?.sendRoutingEvent?(router)
            })
            .disposed(by: disposeBag)
    }
}

extension AppointmentDetailViewController: YakgwaNavigationDetailDelegate {
    public func didTapDetailLeftButton() {
        print("didTapDetailLeftButton")
        self.navigationController?.popViewController(animated: true)
    }
    
    public func didTapDetailRightButton() { }
}
