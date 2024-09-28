//
//  BeforeConfirmView.swift
//  DetailScene
//
//  Created by Kim Dongjoo on 9/26/24.
//

import UIKit

import CoreKit
import Domain
import RxSwift

enum BeforeConfirmViewType {
    case date
    case location
}

final class BeforeConfirmView: UIView {
    // MARK: - Properties
    private let type: BeforeConfirmViewType
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sb14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .m12
        label.textColor = .neutral600
        return label
    }()
    
    private lazy var voteStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var confirmButton: YakGwaButton = {
        let button = YakGwaButton(style: .secondary)
        return button
    }()
    
    init(type: BeforeConfirmViewType) {
        self.type = type
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .neutralWhite
        
        self.layer.cornerRadius = 16
        
        switch type {
        case .date:
            titleLabel.text = "약속 시간 투표 결과"
            descriptionLabel.text = "가장 득표수가 많은 약속 시간이에요."
            confirmButton.title = "시간 확정하고 알림 받기"
        case .location:
            titleLabel.text = "약속 장소 투표 결과"
            descriptionLabel.text = "가장 득표수가 많은 장소에요."
            confirmButton.title = "장소 확정하기"
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(titleLabel)
        }
        
        self.addSubview(voteStack)
        voteStack.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.equalTo(titleLabel)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(voteStack.snp.bottom).offset(16)
            $0.leading.equalTo(titleLabel)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Internal
    func configure(with entity: VoteDateInfo, reactor: AppointmentDetailViewReactor) {
        entity.getTimeInfo()?.forEach { timeInfo in
            let tiedVoteView = TiedVoteView(id: timeInfo.getDateID() ?? 0)
            tiedVoteView.configure(with: timeInfo)
            voteStack.addArrangedSubview(tiedVoteView)
            
            tiedVoteView.radioButtonTapRelay
                .map { id in AppointmentDetailViewReactor.Action.didTapDateRadioButton(id) }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
            
            reactor.state.map { $0.selectedDateSlootId }
                .compactMap({ $0 })
                .distinctUntilChanged()
                .subscribe(onNext: { [weak self] id in
                    self?.updateRadioButtonStates(selectedVoteId: id)
                })
                .disposed(by: disposeBag)
        }
    }
    
    func configure(with entity: VoteLocationInfo, reactor: AppointmentDetailViewReactor) {
        entity.getPlaceInfo().forEach { placeInfo in
            let tiedVoteView = TiedVoteView(id: placeInfo.getPlaceSlotId() ?? 0)
            tiedVoteView.configure(with: placeInfo)
            voteStack.addArrangedSubview(tiedVoteView)
            
            tiedVoteView.radioButtonTapRelay
                .map { id in AppointmentDetailViewReactor.Action.didTapLocationRadioButton(id) }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
            
            reactor.state.map { $0.selectedLocationSlotId }
                .compactMap({ $0 })
                .distinctUntilChanged()
                .subscribe(onNext: { [weak self] id in
                    self?.updateRadioButtonStates(selectedVoteId: id)
                })
                .disposed(by: disposeBag)
        }
    }
    
    private func updateRadioButtonStates(selectedVoteId: Int) {
        for view in voteStack.arrangedSubviews {
            if let tiedVoteView = view as? TiedVoteView {
                tiedVoteView.radioButton.isSelected = (tiedVoteView.id == selectedVoteId)
            }
        }
    }
}
