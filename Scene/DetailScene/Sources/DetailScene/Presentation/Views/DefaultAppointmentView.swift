//
//  DefaultAppointmentView.swift
//
//
//  Created by Ekko on 7/19/24.
//

import UIKit

import CoreKit

public enum DefaultAppointmentViewState {
    /// default
    case none
    /// 초대 수락한 약과원이 존재(초대 마감 전)
    case inviting
    /// 초대 수락한 약과원이 있을 경우(초대 마감 후)
    case invited
}

/// 투표 상태
public enum DefaultAppointmentViewVotedState {
    /// 투표 전
    case before
    /// 투표 후
    case after
}

/// 약속 상태 View
public final class DefaultAppointmentView: UIView {
    // MARK: - Properties
    private let state: DefaultAppointmentViewState
    
    // MARK: - UI Components
    private lazy var voteStateView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary700
        return view
    }()
    
    private lazy var voteStateLabel: UILabel = {
        let label = UILabel()
        label.font = .sb14
        label.textColor = .neutralWhite
        label.text = "투표를 완료했어요"
        return label
    }()
    
    private lazy var tagView: TagView = {
        let view = TagView(tag: "테마명")
        return view
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약과장의 약과모임"
        label.font = .sb18
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 설명입니다. 모임 설명입니다."
        label.font = .m14
        label.textColor = .neutral500
        return label
    }()
    
    private lazy var invitedView: InvitedView = {
        let view = InvitedView()
        return view
    }()
    
    lazy var inviteButton: YakGwaButton = {
        let button = YakGwaButton(style: .secondary, image: .share)
        button.title = "초대하기"
        return button
    }()
    
    // MARK: - Initializers
    init(state: DefaultAppointmentViewState = .none) {
        self.state = state
        super.init(frame: .zero)
        
        attribute()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() {
    }
    
    private func setUI() {
        self.layer.cornerRadius = 25
        self.backgroundColor = .neutralWhite
        self.clipsToBounds = true
        
        self.addSubview(tagView)
        tagView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(titleStack)
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(descriptionLabel)
        
        titleStack.snp.makeConstraints {
            $0.top.equalTo(tagView.snp.bottom).offset(8)
            $0.leading.equalTo(tagView)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.addSubview(invitedView)
        invitedView.snp.makeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(inviteButton)
        inviteButton.snp.makeConstraints {
            $0.top.equalTo(invitedView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Public
    func configure(with viewModel: AppointmentDetailViewModel) {
        tagView.setTag(viewModel.theme)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        invitedView.configure(with: viewModel.participants)
    }
    
    func changeVoteState() {
        self.addSubview(voteStateView)
        voteStateView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        voteStateView.addSubview(voteStateLabel)
        voteStateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        tagView.snp.remakeConstraints {
            $0.top.equalTo(voteStateView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
    }
}
