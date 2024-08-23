//
//  VoteView.swift
//
//
//  Created by Ekko on 8/24/24.
//

import UIKit

import CoreKit

enum VoteType {
    case date
    case location
}

public final class VoteView: UIView {
    // MARK: - Properties
    private var type: VoteType = .date
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sb14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var voteStateLabel: UILabel = {
       let label = UILabel()
        label.font = .m16
        label.textColor = .neutral800
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .m14
        label.textColor = .neutral500
        return label
    }()
    
    private lazy var voteButton: YakGwaButton = {
        let button = YakGwaButton(style: .primary)
        button.title = "시간 투표하기"
        return button
    }()
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        
        attribute()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() { }
    
    private func setUI() {
        self.backgroundColor = .neutralWhite
        self.layer.cornerRadius = 25
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(voteStateLabel)
        voteStateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(voteStateLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(voteButton)
        voteButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Public
    func configure(type: VoteType) {
        if type == .date {
            titleLabel.text = "약속 시간"
            voteStateLabel.text = "지금 투표가 진행 중입니다"
            descriptionLabel.text = "참여 가능한 시간을 투표해주세요"
            voteButton.title = "시간 투표하기"
        } else {
            titleLabel.text = "약속 장소"
            voteStateLabel.text = "지금 투표가 진행 중입니다"
            descriptionLabel.text = "총 4개 후보 중 원하는 장소"
            voteButton.title = "장소 투표하기"
        }
    }
}
