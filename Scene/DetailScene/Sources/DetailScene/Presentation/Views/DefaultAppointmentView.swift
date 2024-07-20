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
    
    private lazy var endHourLabel: UILabel = {
        let label = UILabel()
        label.text = "N시간 뒤 초대 마감"
        label.font = .sb14
        label.textColor = .primary800
        return label
    }()
    
    private lazy var invitedView: InvitedView = {
        let view = InvitedView()
        return view
    }()
    
    private lazy var inviteButton: YakGwaButton = {
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
        switch state {
        case .none, .inviting:
            endHourLabel.text = "N시간 뒤 초대 마감"
        case .invited:
            endHourLabel.text = "초대 완료"
        }
    }
    
    private func setUI() {
        self.layer.cornerRadius = 25
        self.backgroundColor = .neutralWhite
        
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
        
        self.addSubview(endHourLabel)
        endHourLabel.snp.makeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(16)
            $0.leading.equalTo(tagView)
        }
        
        self.addSubview(invitedView)
        invitedView.snp.makeConstraints {
            $0.top.equalTo(endHourLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(inviteButton)
        inviteButton.snp.makeConstraints {
            $0.top.equalTo(invitedView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

#Preview {
    DefaultAppointmentView()
}
