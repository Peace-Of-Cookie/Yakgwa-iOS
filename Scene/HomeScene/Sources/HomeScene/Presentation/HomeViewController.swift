//
//  HomeViewController.swift
//
//
//  Created by Kim Dongjoo on 7/10/24.
//

import UIKit
import CoreKit
import Util
import Local

import SnapKit
import ReactorKit

public class HomeViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    var sendRoutingEvent: ((HomeRouter) -> Void)?
    var testSubject: PublishSubject<HomeRouter> = PublishSubject<HomeRouter>()
    
    // MARK: - UI Components
    private lazy var yakgwaLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "yakgwa_label_icon", in: .module, with: nil)
        // image.backgroundColor = .systemRed
        return image
    }()
    
    private lazy var alarmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell_icon", in: .module, with: nil), for: .normal)
        return button
    }()
    
    private lazy var appointmentView: AppointmentView = {
        let view = AppointmentView()
        return view
    }()
    
    private lazy var noAppointmentView: NoAppointmentView = {
        let view = NoAppointmentView()
        return view
    }()
    
    private var homeCollectionView: UICollectionView!
    
    // MARK: - Initializers
    public init(
        reactor: HomeReactor
    ) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .neutral200
        setUI()
    }
    
    // MARK: - Privates
    private func setUI() {
        view.addSubview(alarmButton)
        alarmButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(yakgwaLogo)
        yakgwaLogo.snp.makeConstraints {
            $0.centerY.equalTo(alarmButton)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(noAppointmentView)
        noAppointmentView.snp.makeConstraints {
            $0.top.equalTo(yakgwaLogo.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
        
    }
    
    public func bind(reactor: HomeReactor) {
        // Action
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        noAppointmentView.createButton.rx.tap
            .map { Reactor.Action.didTapCreateAppointmentButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map { $0.appointments }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] appointments in
                print("약속: \(appointments)")
            })
            .disposed(by: disposeBag)
        
        // Routing
        reactor.route
            .subscribe(onNext: { [weak self] router in
                switch router {
                case .create:
                    print("탕후루")
                    self?.sendRoutingEvent?(.create)
                    if let sendRoutingEvent = self?.sendRoutingEvent {
                        print("sendRoutingEvent is set")
                    } else {
                        print("sendRoutingEvent is nil")
                    }
                    // self?.testSubject.onNext(.create)
                }
            })
            .disposed(by: disposeBag)
    }
}
