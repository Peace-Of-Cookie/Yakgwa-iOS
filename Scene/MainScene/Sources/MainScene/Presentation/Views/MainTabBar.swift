//
//  MainTabBar.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import UIKit
import CoreKit

protocol MainTabBarDelegate: AnyObject {
    func centerButtonTapped()
}

final class MainTabBar: UITabBar {
    // MARK: - Properties
    weak var customDelegate: MainTabBarDelegate?
    
    // MARK: - Layout
    private struct Appearance {
        static let height: CGFloat = 61.0
        static let buttonHeight: CGFloat = 70.0
        static let buttonWidth: CGFloat = 70.0
    }
    
    // MARK: - UI Components
    private lazy var centerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let image = UIImage(named: "yakgwa_plus", in: .module, with: nil)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = Appearance.buttonHeight / 2
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    // MARK: - Privates
    private func setUI() {
        self.addSubview(centerButton)
        centerButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(Appearance.buttonHeight)
        }
    }
    
    private func setupAppearance() {
        self.backgroundColor = .neutralWhite // 탭바 배경색 설정
        self.tintColor = .neutralBlack // 선택된 아이템 색상 설정
        self.unselectedItemTintColor = .neutral500 // 선택되지 않은 아이템 색상 설정
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = Appearance.height + UIDevice.current.safeAreaBottomHeight
        return sizeThatFits
    }
    
    @objc
    func centerButtonTapped() {
        customDelegate?.centerButtonTapped()
    }
}
