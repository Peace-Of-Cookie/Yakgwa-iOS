//
//  MainTabBar.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import UIKit
import CoreKit
final class MainTabBar: UITabBar {
    
    // MARK: - Layout
    
    private struct Appearance {
        static let height: CGFloat = 61.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
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
}
