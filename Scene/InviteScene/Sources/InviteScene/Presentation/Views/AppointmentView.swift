//
//  AppointmentView.swift
//
//
//  Created by Kim Dongjoo on 8/23/24.
//

import UIKit

import CoreKit

public final class AppointmentView: UIView {
    // MARK: - Properties
    
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
    
    // MARK: - Initializers
    init() {
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
}
