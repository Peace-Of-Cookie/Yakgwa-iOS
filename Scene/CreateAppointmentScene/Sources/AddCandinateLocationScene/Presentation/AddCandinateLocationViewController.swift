//
//  AddCandinateLocationViewController.swift
//
//
//  Created by Kim Dongjoo on 8/6/24.
//

import UIKit

import CoreKit
import ReactorKit

public final class AddCandinateLocationViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    var sendRoutingEvent: ((AddCandinateLocationRouter) -> Void)?
    
    // MARK: - UI Components
    private lazy var navigationBar: YakgwaNavigationDetailBar = {
        let nav = YakgwaNavigationDetailBar()
        nav.delegate = self
        nav.configure(previousTitle: "장소 후보 추가")
        return nav
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
    
    private lazy var bottomSheetButton: BottomSheetButton = {
        let button = BottomSheetButton(title: "확인")
        return button
    }()
    
    // MARK: - Initializers
    public init(
        reactor: AddCandinateLocationReactor
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
        
        self.view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(32)
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
    
    public func bind(reactor: AddCandinateLocationReactor) {
        // Action
        searchTextField.rx.text
            .orEmpty
            .map { Reactor.Action.editQuery($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map { $0.searchResults }
            .bind(to: resultTableView.rx.items(cellIdentifier: LocationCell.identifier, cellType: LocationCell.self)) { _, element, cell in
                cell.configure(
                    title: element.title,
                    address: element.address,
                    isBookmarked: element.isBookMark
                )
            }
            .disposed(by: disposeBag)
        
        // Routing
    }
}

extension AddCandinateLocationViewController: YakgwaNavigationDetailDelegate {
    public func didTapDetailLeftButton() {
        print("didTapDetailLeftButton")
        self.navigationController?.popViewController(animated: true)
    }
}
