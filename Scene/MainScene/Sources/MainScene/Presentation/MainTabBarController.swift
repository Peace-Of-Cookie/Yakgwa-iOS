//
//  MainTabBarController.swift
//
//
//  Created by Kim Dongjoo on 7/11/24.
//

import UIKit

import ReactorKit
import CoreKit
import Util
import RxCocoa

import HomeScene
import SplashScene

public final class MainTabBarController: UITabBarController, View {
    // MARK: - Properties
    public var disposeBag = DisposeBag()
    
    // MARK: - Initializers
    public init(
        reactor: MainTabBarViewReactor
    ) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        let tabBar = MainTabBar()
        self.setValue(tabBar, forKey: "tabBar")
        let homeViewController = HomeViewController()
        homeViewController.title = "홈"
        let splashViewController = SplashViewController(reactor: SplashReactor())
        splashViewController.title = "테스트"
        self.viewControllers = [homeViewController, splashViewController]
            .map { viewController -> UINavigationController in
                let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.tabBarItem.imageInsets.top = 5
                navigationController.tabBarItem.imageInsets.bottom = -5
                return navigationController
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Privates
    public func bind(reactor: MainTabBarViewReactor) {
        print("bind")
    }
}

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


#Preview {
    MainTabBarController(reactor: MainTabBarViewReactor())
}
