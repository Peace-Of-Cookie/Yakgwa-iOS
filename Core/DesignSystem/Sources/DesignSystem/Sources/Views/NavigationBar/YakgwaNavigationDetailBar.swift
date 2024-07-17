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
}

public final class YakgwaNavigationDetailBar: UIView {
    // MARK: - Properties
    public weak var delegate: YakgwaNavigationDetailDelegate?
    
    private let horizontalInset: CGFloat = 16
    
    // MARK: - UI Componenets
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backward_icon", in: .module, with: nil), for: .normal)
        button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
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
        previousTitle: String?
    ) {
        self.previousViewTitle.text = previousTitle
    }
    
    // MARK: - Privates
    private func setUI() {
        self.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        
        self.addSubview(leftButton)
        leftButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(horizontalInset)
        }
        
        self.addSubview(previousViewTitle)
        previousViewTitle.snp.makeConstraints {
            $0.leading.equalTo(leftButton.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc
    private func leftButtonTapped() {
        delegate?.didTapDetailLeftButton()
    }
}

#Preview {
    YakgwaNavigationDetailBar()
}
