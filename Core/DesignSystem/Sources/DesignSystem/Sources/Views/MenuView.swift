//
//  MenuView.swift
//
//
//  Created by Kim Dongjoo on 8/7/24.
//

import UIKit

public final class MenuView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .m16
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .r10
        label.textColor = .neutral600
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "forward_icon_600", in: .module, with: nil), for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    public init(
        title: String = "",
        description: String = ""
    ) {
        super.init(frame: .zero)
        
        if title.isEmpty {
            titleLabel.isHidden = true
        } else {
            titleLabel.text = title
        }
        
        if description.isEmpty {
            descriptionLabel.isHidden = true
        } else {
            descriptionLabel.text = description
        }
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.layer.cornerRadius = 25
        
        self.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.center.equalToSuperview()
        }
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(descriptionLabel)
        
        rightButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
