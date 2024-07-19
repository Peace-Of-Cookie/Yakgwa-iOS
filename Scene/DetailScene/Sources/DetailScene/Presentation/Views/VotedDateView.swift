//
//  VotedDateView.swift
//
//
//  Created by Ekko on 7/20/24.
//

import UIKit

import CoreKit

public final class VotedDateView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var votedLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 투표한 시간"
        label.font = .sb14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var votedStackContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral200
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var votedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var revoteButton: YakGwaButton = {
        let button = YakGwaButton(style: .secondary, image: .rightArrowBlack)
        button.title = "시간 다시 투표하기"
        return button
    }()
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        
        attribute()
        setUI()
        test()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() {
        
    }
    
    private func setUI() {
        self.backgroundColor = .neutralWhite
        self.layer.cornerRadius = 25
        
        self.addSubview(votedLabel)
        votedLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(votedStackContainer)
        votedStackContainer.snp.makeConstraints {
            $0.top.equalTo(votedLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        votedStackContainer.addSubview(votedStackView)
        votedStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.addSubview(revoteButton)
        revoteButton.snp.makeConstraints {
            $0.top.equalTo(votedStackContainer.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func test() {
        for i in 0..<3 {
            let label = UILabel()
            label.text = "2021.07.20 15:00 | \(i)시"
            label.font = .m12
            label.textColor = .neutral800
            self.votedStackView.addArrangedSubview(label)
        }
    }
}

#Preview {
    VotedDateView()
}
