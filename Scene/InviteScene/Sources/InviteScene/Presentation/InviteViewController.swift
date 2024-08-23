//
//  InviteViewController.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
//

import UIKit

import CoreKit
import ReactorKit
import Domain
import RxCocoa

public final class InviteViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    var sendRoutingEvent: ((InviteRouter) -> Void)?
    
    // MARK: - UI Components
    private lazy var navigationBar: YakgwaNavigationDetailBar = {
        let nav = YakgwaNavigationDetailBar()
        nav.delegate = self
        nav.configure(previousTitle: "약속 참여하기", rightButtonIsEnable: true)
        nav.hideLeftButton()
        return nav
    }()
    
    private lazy var bottomSheetButton: BottomSheetButton = {
        let button = BottomSheetButton(title: "참여하기")
        return button
    }()
    
    private lazy var masterLabel: UILabel = {
        let label = UILabel()
        label.font = .m14
        label.textColor = .neutral700
        label.text = "xxx님이 약속에 초대했어요"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var appointmentDetailView: AppointmentView = {
        let view = AppointmentView()
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
    
    // MARK: - Initializers
    public init(
        reactor: InviteReactor
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
        
        self.view.addSubview(masterLabel)
        masterLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(bottomSheetButton)
        bottomSheetButton.snp.makeConstraints {
            $0.height.equalTo(92)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        self.view.addSubview(appointmentDetailView)
        appointmentDetailView.snp.makeConstraints {
            $0.top.equalTo(masterLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
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
    public func bind(reactor: InviteReactor) {
        // Action
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        bottomSheetButton.rx.tap
            .map { Reactor.Action.joinButtonDidTap }
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

extension InviteViewController: YakgwaNavigationDetailDelegate {
    public func didTapDetailLeftButton() {
        print("didTapDetailLeftButton")
        self.navigationController?.popViewController(animated: true)
    }
    
    public func didTapDetailRightButton() {
        print("didTapDetailRightButton")
        self.navigationController?.popViewController(animated: true)
    }
}
