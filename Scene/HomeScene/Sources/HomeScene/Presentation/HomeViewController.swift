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
    
    // MARK: - UI Components
    private lazy var yakgwaLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "yakgwa_label_icon", in: .module, with: nil)
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
        view.isHidden = true
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .neutral300
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var popupView: YakgwaPopUpView = {
        let view = YakgwaPopUpView()
        view.isHidden = true
        return view
    }()
    
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let inset = (UIScreen.main.bounds.width - (UIScreen.main.bounds.width - 8)) / 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(AppointmentCell.self, forCellWithReuseIdentifier: AppointmentCell.identifier)
        view.delegate = self

        return view
    }()
    
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
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
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(popupView)
        popupView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
            .map { $0.noAppointmentViewIsHidden }
            .subscribe(onNext: { [weak self] isHidden in
                if isHidden {
                    self?.showCollectionView()
                } else {
                    self?.showNoAppointmentView()
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.appointments }
            .distinctUntilChanged()
            .bind(to: homeCollectionView.rx.items(
                cellIdentifier: "AppointmentCell",
                cellType: AppointmentCell.self)
            ) { index, appointment, cell in
                
                cell.configure(with: appointment)
                
                cell.appointmentView.detailButton.rx.tap
                    .map { Reactor.Action.didTapDetailButton(index) }
                    .bind(to: reactor.action)
                    .disposed(by: cell.disposeBag)
            }
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

extension HomeViewController {
    private func showNoAppointmentView() {
        noAppointmentView.isHidden = false
        
        homeCollectionView.removeFromSuperview()
        
        view.addSubview(noAppointmentView)
        noAppointmentView.snp.makeConstraints {
            $0.top.equalTo(yakgwaLogo.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func showCollectionView() {
        noAppointmentView.removeFromSuperview()
        
        view.addSubview(homeCollectionView)
        homeCollectionView.snp.makeConstraints {
            $0.top.equalTo(yakgwaLogo.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(256)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width - 8, height: 256)
    }
}
