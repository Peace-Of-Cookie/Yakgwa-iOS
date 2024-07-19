//
//  InvitedView.swift
//
//
//  Created by Ekko on 7/19/24.
//

import UIKit

import CoreKit

public enum InvitedState {
    case none
    case invited
}

public final class InvitedView: UIView  {
    // MARK: - Properties
    private var state: InvitedState = .none {
        didSet {
            switch state {
            case .none:
                noneLabel.isHidden = false
                profileImageStack.isHidden = true
            case .invited:
                noneLabel.isHidden = true
                profileImageStack.isHidden = false
            }
        }
    }
    
    // MARK: - UI Components
    private lazy var noneLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 참여 중인 사람이 없습니다.\n초대장을 보내 약속을 진행해보세요"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .r14
        label.textColor = .neutral600
        return label
    }()

    private lazy var profileStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private lazy var profileImageStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = -8
        return stack
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "+N명"
        label.font = .m12
        label.textColor = .neutral800
        label.isHidden = true
        return label
    }()
    
    private lazy var showAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 보기 >", for: .normal)
        button.setTitleColor(.neutral600, for: .normal)
        button.titleLabel?.font = .m11
        return button
    }()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        setUI()
        setProfileStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .neutral200
        self.layer.cornerRadius = 16
        
        self.addSubview(noneLabel)
        noneLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(56)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(profileStack)
        profileStack.addArrangedSubview(profileImageStack)
        profileStack.addArrangedSubview(numberLabel)
        profileStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(showAllButton)
        showAllButton.snp.makeConstraints {
            $0.top.equalTo(profileStack.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-8)
            $0.centerX.equalToSuperview()
        }
    }
    
#warning("TODO : - UI Test ")
    private func setProfileStack() {
        let count = 6
        if count > 5 {
            numberLabel.isHidden = false
            for _ in 0..<5 {
                let profileView = ProfileView(isNew: true)
                profileImageStack.addArrangedSubview(profileView)
            }
        } else {
            for _ in 0..<count {
                let profileView = ProfileView(isNew: true)
                profileImageStack.addArrangedSubview(profileView)
            }
        }
        
    }
}

#Preview {
    InvitedView()
}

