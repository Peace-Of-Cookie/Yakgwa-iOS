//
//  MainTabBarCoordinator.swift
//
//
//  Created by Ekko on 7/22/24.
//

import UIKit

import CoreKit
import Util

import HomeScene
import MyPageScene

@MainActor
public final class MainTabBarCoordinator: BaseCoordinator {
    // MARK: - Properties
    private let window: UIWindow
    
    let viewController: MainTabBarController
    
    // MARK: - Initializers
    public init(
        window: UIWindow,
        viewController: MainTabBarController
    ) {
        self.window = window
        self.viewController = viewController
        super.init(navigationController: nil)
    }
    
    // MARK: - Public
    public override func start() {
        configureTabBar()
        self.window.rootViewController = self.viewController
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Privates
    public func configureTabBar() {
        let homeViewController = HomeViewController()
        let homeCoordinator = HomeCoordinator(
            navigationController: UINavigationController(),
            viewController: homeViewController
        )
        homeCoordinator.start()
        
        let myPageViewController = MyPageViewController()
        let myPageCoordinator = MyPageCoordinator(
            navigationController: UINavigationController(),
            viewController: myPageViewController
        )
        myPageCoordinator.start()
        
        guard let homeNavController = homeCoordinator.navigationController,
              let myPageNavController = myPageCoordinator.navigationController else {
            fatalError("Navigation controllers should not be nil")
        }
        
        homeNavController.tabBarItem.image = UIImage(named: "home_tab_icon", in: .module, with: nil)
        homeNavController.tabBarItem.title = "홈"
        homeNavController.setNavigationBarHidden(true, animated: false)
        
        myPageNavController.tabBarItem.image = UIImage(named: "profile_tab_icon", in: .module, with: nil)
        myPageNavController.tabBarItem.title = "마이"
        myPageNavController.setNavigationBarHidden(true, animated: false)
        
        self.viewController.viewControllers = [
            homeNavController,
            myPageNavController
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String?, image: UIImage, selectedImage: UIImage) -> UIViewController {
            
            let navController = UINavigationController(rootViewController:  rootViewController)
            navController.navigationBar.isTranslucent = false
            navController.navigationBar.backgroundColor = .white
            navController.tabBarItem.title = title
            navController.tabBarItem.image = image
            navController.tabBarItem.selectedImage = selectedImage
            // navController.interactivePopGestureRecognizer?.delegate = nil // 스와이프 제스처 enable true
            return navController
        }
}
