//
//  LocationVoteViewController.swift
//
//
//  Created by Ekko on 7/21/24.
//

import UIKit

import CoreKit
import ReactorKit
import Domain

public final class LocationVoteViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    var sendRoutingEvent: ((LocationVoteRouter) -> Void)?
    
    // MARK: - UI Components
    private lazy var navigationBar: YakgwaNavigationDetailBar = {
        let nav = YakgwaNavigationDetailBar()
        nav.delegate = self
        nav.configure(previousTitle: "약속 시간 투표")
        return nav
    }()
    
    private lazy var bottomSheetButton: BottomSheetButton = {
        let button = BottomSheetButton(title: "투표 완료")
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.register(LocationVotingCell.self, forCellReuseIdentifier: LocationVotingCell.identifier)
        tableView.register(AddLocationCandidateCell.self, forCellReuseIdentifier: AddLocationCandidateCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
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
        reactor: LocationVoteReactor
    ) {
        defer { self.reactor = reactor}
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
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
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(bottomSheetButton.snp.top).offset(-8)
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
    public func bind(reactor: LocationVoteReactor) {
        // Action
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.bottomSheetButton.rx.tap
            .map { Reactor.Action.voteButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { Reactor.Action.didTapCandidateCell($0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.candidates }
            .distinctUntilChanged()
            .map { candidates -> [LocationVoteCandidateType] in
                var allCandidates = candidates.map { LocationVoteCandidateType.candidate($0) }
                allCandidates.append(.addLocation) // 마지막에 AddLocationCandidateCell 추가
                return allCandidates
            }
            .bind(to: tableView.rx.items) { tableView, index, item in
                switch item {
                case .candidate(let candidate):
                    let cell = tableView.dequeueReusableCell(withIdentifier: LocationVotingCell.identifier, for: IndexPath(row: index, section: 0)) as! LocationVotingCell
                    cell.configure(with: candidate)
                    return cell
                case .addLocation:
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddLocationCandidateCell.identifier, for: IndexPath(row: index, section: 0)) as! AddLocationCandidateCell
                    return cell
                }
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

// MARK: - Privates
extension LocationVoteViewController {

}

// MARK: - NavigationBarDelegate
extension LocationVoteViewController: YakgwaNavigationDetailDelegate {
    public func didTapDetailLeftButton() {
        print("didTapDetailLeftButton")
        self.navigationController?.popViewController(animated: true)
    }
    
    public func didTapDetailRightButton() { }
}

// MARK: - TableViewDelegates
extension LocationVoteViewController: UITableViewDelegate {
}

// MARK: - TableView CandidateType
enum LocationVoteCandidateType {
    case candidate(CandidateViewModel) // 후보지 셀
    case addLocation // 후보지 추가 셀
}
