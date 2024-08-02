//
//  SelectAppointmentThemeViewController.swift
//
//
//  Created by Ekko on 7/18/24.
//

import UIKit

import CoreKit
import ReactorKit

public final class SelectAppointmentThemeViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    var sendRoutingEvent: ((SelectAppointmentThemeRouter) -> Void)?
    
    // MARK: - UI Components
    private lazy var navigationBar: YakgwaNavigationDetailBar = {
        let nav = YakgwaNavigationDetailBar()
        nav.delegate = self
        nav.configure(previousTitle: "약속 만들기")
        return nav
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약속의 목적이 무엇인가요?"
        label.font = .m14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.createCollectionViewLayout())
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(ThemeCell.self, forCellWithReuseIdentifier: ThemeCell.identifier)
        view.delegate = self
        return view
    }()
    
    private lazy var bottomSheetButton: BottomSheetButton = {
        let button = BottomSheetButton(title: "다음으로")
        return button
    }()
    
    // MARK: - Initializers
    public init(
        reactor: SelectAppointmentThemeReactor
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
        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(bottomSheetButton.snp.top)
            $0.leading.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / 3.0),
                                              heightDimension: .fractionalWidth(1.0 / 3.0 * 1.05))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0 / 3.0 * 1.05))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item, item, item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    public func bind(reactor: SelectAppointmentThemeReactor) {
        // Action
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.collectionView.rx.itemSelected
            .map { Reactor.Action.selectTheme($0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map { $0.themes }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(
                cellIdentifier: "ThemeCell",
                cellType: ThemeCell.self)
            ) { index, theme, cell in
                let isSelected = (index == reactor.currentState.selectedTheme)
                cell.configure(with: theme, isSelected: isSelected)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.selectedTheme }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // Routing
    }
}

extension SelectAppointmentThemeViewController: UICollectionViewDelegate {

}

extension SelectAppointmentThemeViewController: YakgwaNavigationDetailDelegate {
    public func didTapDetailLeftButton() {
        navigationController?.popViewController(animated: true)
    }
}
