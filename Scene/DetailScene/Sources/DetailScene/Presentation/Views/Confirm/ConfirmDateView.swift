//
//  ConfirmDateView.swift
//  DetailScene
//
//  Created by Kim Dongjoo on 9/26/24.
//

import UIKit

import CoreKit
import Domain

public final class ConfirmDateView: UIView {
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sb14
        label.textColor = .neutralBlack
        label.text = "약속 시간"
        return label
    }()
    
    private lazy var dateStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024년 5월 4일"
        label.font = .r16
        return label
    }()

    private lazy var dateSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral300
        return view
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "오후 0시"
        label.font = .r16
        return label
    }()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .neutralWhite
        self.layer.cornerRadius = 25
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(dateStack)
        dateStack.addArrangedSubview(dateLabel)
        dateStack.addArrangedSubview(dateSeparator)
        dateSeparator.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
        dateStack.addArrangedSubview(timeLabel)
        dateStack.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Publics
    func configure(with entity: VoteDateInfo) {
        if let date = entity.getTimeInfo()?.first?.getVoteTime() {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            self.dateLabel.text = dateFormatter.string(from: date)
            
            let timeFormatter = DateFormatter()
            timeFormatter.locale = Locale(identifier: "ko_KR")
            timeFormatter.amSymbol = "오전"
            timeFormatter.pmSymbol = "오후"
            timeFormatter.dateFormat = "a h시"
            self.timeLabel.text = timeFormatter.string(from: date)
        }
    }
}
