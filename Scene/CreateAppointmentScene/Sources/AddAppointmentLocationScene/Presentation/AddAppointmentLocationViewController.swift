//
//  AddAppointmentLocationViewController.swift
//
//
//  Created by Ekko on 7/17/24.
//

import UIKit

import CoreKit
import ReactorKit
import Domain

public final class AddAppointmentLocationViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    var sendRoutingEvent: ((AddAppointmentLocationRouter) -> Void)?
    
    // MARK: - UI Components
    private lazy var navigationBar: YakgwaNavigationDetailBar = {
        let nav = YakgwaNavigationDetailBar()
        nav.delegate = self
        nav.configure(previousTitle: "약속 만들기")
        return nav
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약속 장소 후보를 추가해 주세요"
        label.font = .m14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 3개 추가 기능"
        label.font = .m11
        label.textColor = .neutral600
        return label
    }()
    
    private lazy var yakgwaSwitchView: YakgwaSwitchView = {
        let view = YakgwaSwitchView()
        view.delegate = self
        return view
    }()
    
    private lazy var bottomSheetButton: BottomSheetButton = {
        let button = BottomSheetButton(title: "다음으로")
        return button
    }()
    
    private lazy var addLocationButton: YakGwaButton = {
        let button = YakGwaButton(style: .white, image: .plus)
        button.title = "후보지 추가하기"
        return button
    }()
    
    private lazy var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var searchTextField: YakgwaSearchTextField = {
        let textField = YakgwaSearchTextField(placeholder: "장소나 주소를 검색해주세요")
        return textField
    }()
    
    private lazy var resultTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Initializers
    public init(
        reactor: AddAppointmentLocationReactor
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
        
        self.view.addSubview(yakgwaSwitchView)
        yakgwaSwitchView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(titleStack)
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(descriptionLabel)
        
        titleStack.snp.makeConstraints {
            $0.top.equalTo(yakgwaSwitchView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.view.addSubview(addLocationButton)
        addLocationButton.snp.makeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(locationStack)
        locationStack.snp.makeConstraints {
            $0.top.equalTo(addLocationButton.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    public func bind(reactor: AddAppointmentLocationReactor) {
        // Action
        self.addLocationButton.rx.tap
            .map { Reactor.Action.didTapSearchButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.bottomSheetButton.rx.tap
            .map { Reactor.Action.didTapCreateButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.searchTextField.rx.text
            .orEmpty
            .map { Reactor.Action.editQuery($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.resultTableView.rx.itemSelected
            .map { Reactor.Action.didTapLocationCell($0.row) }
            .do(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        self.reactor?.state
            .map { $0.locations }
            .bind { [weak self] locations in
                self?.locationStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
                locations.forEach { location in
                    let view = LocationView()
                    view.configure(
                        title: location.title,
                        address: location.address
                    )
                    self?.locationStack.addArrangedSubview(view)
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.searchResults }
            .bind(to: resultTableView.rx.items(cellIdentifier: LocationCell.identifier, cellType: LocationCell.self)) { _, element, cell in
                cell.configure(
                    title: element.title,
                    address: element.address,
                    isBookmarked: false, 
                    isSelected: element.isSelected
                )
            }
            .disposed(by: disposeBag)
        
        // Routing
        reactor.route
            .subscribe(onNext: { [weak self] router in
                self?.sendRoutingEvent?(router)
            })
            .disposed(by: disposeBag)
    }
    
    private func changeMode(state: YakgwaSwitchViewState) {
        if state == .first {
            titleLabel.text = "약속 장소 후보를 추가해 주세요"
            descriptionLabel.text = "최대 3개 추가 기능"
            titleStack.addArrangedSubview(descriptionLabel)
            
            searchTextField.removeFromSuperview()
            resultTableView.removeFromSuperview()
            
            self.view.addSubview(addLocationButton)
            addLocationButton.snp.makeConstraints {
                $0.top.equalTo(titleStack.snp.bottom).offset(8)
                $0.leading.equalToSuperview().offset(16)
                $0.centerX.equalToSuperview()
            }
            
            self.view.addSubview(locationStack)
            locationStack.snp.makeConstraints {
                $0.top.equalTo(addLocationButton.snp.bottom).offset(32)
                $0.leading.equalToSuperview().offset(16)
                $0.centerX.equalToSuperview()
            }
        } else {
            titleLabel.text = "정해진 약속 장소를 입력해주세요."
            descriptionLabel.text = ""
            titleStack.removeArrangedSubview(descriptionLabel)
            
            addLocationButton.removeFromSuperview()
            locationStack.removeFromSuperview()
            
            self.view.addSubview(searchTextField)
            searchTextField.snp.makeConstraints {
                $0.top.equalTo(titleStack.snp.bottom).offset(16)
                $0.leading.equalToSuperview().offset(16)
                $0.centerX.equalToSuperview()
            }
            
            self.view.addSubview(resultTableView)
            resultTableView.snp.makeConstraints {
                $0.top.equalTo(searchTextField.snp.bottom).offset(16)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(bottomSheetButton.snp.top).offset(-16)
            }
        }
    }
}

extension AddAppointmentLocationViewController: YakgwaNavigationDetailDelegate {
    public func didTapDetailLeftButton() {
        print("didTapDetailLeftButton")
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddAppointmentLocationViewController: YakgwaSwitchViewDelegate {
    public func yakgwaSwitchView(state: YakgwaSwitchViewState) {
        print("yakgwaSwitchMode: \(state)")
        self.changeMode(state: state)
    }
}
