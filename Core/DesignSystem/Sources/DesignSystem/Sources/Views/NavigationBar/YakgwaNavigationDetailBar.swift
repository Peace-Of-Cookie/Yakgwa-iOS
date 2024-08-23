//
//  YakgwaNavigationDetailBar.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import UIKit
import Util

public protocol YakgwaNavigationDetailDelegate: AnyObject {
    func didTapDetailLeftButton()
    func didTapDetailRightButton()
}

public final class YakgwaNavigationDetailBar: UIView {
    // MARK: - Properties
    public weak var delegate: YakgwaNavigationDetailDelegate?
    
    private let horizontalInset: CGFloat = 16
    
    // MARK: - UI Componenets
    private lazy var leftStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backward_icon", in: .module, with: nil), for: .normal)
        button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        return button
    }() 
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_icon", in: .module, with: nil), for: .normal)
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var previousViewTitle: UILabel = {
        let label = UILabel()
        label.font = .sb18
        label.textColor = .neutralBlack
        return label
    }()
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    /// Navigation 버튼 타이틀 설정
    public func configure(
        previousTitle: String?,
        rightButtonIsEnable: Bool = false
    ) {
        self.previousViewTitle.text = previousTitle
        self.rightButton.isHidden = !rightButtonIsEnable
    }
    
    public func hideLeftButton() {
        self.leftButton.isHidden = true
    }
    
    // MARK: - Privates
    private func setUI() {
        self.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        self.addSubview(leftStack)
        leftStack.snp.makeConstraints {
            $0.leading.equalTo(horizontalInset)
            $0.centerY.equalToSuperview()
        }
        
        leftStack.addArrangedSubview(leftButton)
        leftButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
        
        self.addSubview(rightButton)
        rightButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.trailing.equalTo(-horizontalInset)
            $0.centerY.equalToSuperview()
        }
        
        leftStack.addArrangedSubview(previousViewTitle)
    }
    
    @objc
    private func leftButtonTapped() {
        delegate?.didTapDetailLeftButton()
    }
    
    @objc
    private func rightButtonTapped() {
        delegate?.didTapDetailRightButton()
    }
}

#Preview {
    YakgwaNavigationDetailBar()
}
