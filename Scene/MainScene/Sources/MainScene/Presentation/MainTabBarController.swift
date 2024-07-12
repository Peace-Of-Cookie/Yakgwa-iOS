//
//  MainTabBarController.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import UIKit

import ReactorKit
import CoreKit
import Util
import RxCocoa

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
        
//        self.viewControllers = [homeViewController, splashViewController]
//            .map { viewController -> UINavigationController in
//                let navigationController = UINavigationController(rootViewController: viewController)
//                navigationController.tabBarItem.imageInsets.top = 5
//                navigationController.tabBarItem.imageInsets.bottom = -5
//                return navigationController
//            }
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

#Preview {
    MainTabBarController(reactor: MainTabBarViewReactor())
}
