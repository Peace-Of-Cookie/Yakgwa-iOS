//
//  TiedVoteView.swift
//  DetailScene
//
//  Created by Kim Dongjoo on 9/26/24.
//

import UIKit

import CoreKit
import Domain
import RxSwift
import RxCocoa

final class TiedVoteView: UIView {
    // MARK: - Properties
    var id: Int
    var radioButtonTapRelay = PublishRelay<Int>()
    
    // MARK: - UI Components
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy var radioButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "radio_deselect_icon", in: .module, with: nil), for: .normal)
        button.setImage(UIImage(named: "radio_select_icon", in: .module, with: nil), for: .selected)
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .r16
        label.textColor = .neutralBlack
        label.textAlignment = .left
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral300
        return view
    }()
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.font = .r16
        label.textColor = .neutralBlack
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Initializers
    init(id: Int) {
        self.id = id
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .neutral200
        self.layer.cornerRadius = 12
        
        self.addSubview(radioButton)
        radioButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.equalToSuperview().offset(8)
            $0.top.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(radioButton.snp.trailing).offset(8)
            $0.centerY.equalTo(radioButton)
        }
        
        self.addSubview(separator)
        separator.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(11)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(radioButton)
        }
        
        self.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.leading.equalTo(separator.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview().offset(-8)
            $0.centerY.equalTo(radioButton)
        }
    }
    
    // MARK: - Functions
    func configure(with entity: VoteDateInfo.TimeInfo) {
        if let date = entity.getVoteTime() {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            self.titleLabel.text = dateFormatter.string(from: date)
            
            let timeFormatter = DateFormatter()
            timeFormatter.locale = Locale(identifier: "ko_KR")
            timeFormatter.amSymbol = "오전"
            timeFormatter.pmSymbol = "오후"
            timeFormatter.dateFormat = "a h시"
            self.subLabel.text = timeFormatter.string(from: date)
        }
    }
    
    func configure(with entity: VoteLocationInfo.PlaceInfo) {
        self.titleLabel.text = entity.getTitle()
        let address = entity.getAddress() ?? ""
        let addressComponents = address.split(separator: " ").prefix(2) // 앞 두 단어만 추출
        let truncatedAddress = addressComponents.joined(separator: " ") // 다시 문자열로 결합
        self.subLabel.text = truncatedAddress
    }
    
    // MARK: - Action
    @objc 
    private func radioButtonTapped() {
        radioButtonTapRelay.accept(self.id)
    }
}
