//
//  TiedVoteView.swift
//  DetailScene
//
//  Created by Kim Dongjoo on 9/26/24.
//

import UIKit

import CoreKit

final class TiedVoteView: UIView {
    // MARK: - Properties
    private let title: String
    private let sub: String
    
    // MARK: - UI Components
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private lazy var radioButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .m16
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral300
        return view
    }()
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.font = .m16
        label.textColor = .neutralBlack
        return label
    }()
    
    // MARK: - Initializers
    init(
        title: String,
        sub: String
    ) {
        self.title = title
        self.sub = sub
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
        
        self.titleLabel.text = title
        self.subLabel.text = sub
        
        self.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.center.equalToSuperview()
        }
        
        stack.addArrangedSubview(radioButton)
        radioButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(separator)
        stack.addArrangedSubview(subLabel)
    }
}
