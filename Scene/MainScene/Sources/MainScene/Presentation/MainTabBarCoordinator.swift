//
//  MainTabBarCoordinator.swift
//
//
//  Created by Ekko on 7/22/24.
//

import UIKit

import CoreKit
import Util
import Domain
import Data

import HomeScene
import MyPageScene
import InputAppointmentInfoScene

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
        self.setRoute()
    }
    
    // MARK: - Privates
    public func configureTabBar() {
        let reactor = HomeReactor(
            fetchAppointmentUsecase: FetchCurrentAppointmentUsecase(
                repository: FetchCurrentAppointmentsRepository(
                    remoteDataSource: RemoteFetchCurrentAppointmentsDataSource(
                    )
                )
            )
        )
        
        let homeViewController = HomeViewController(reactor: reactor)
        let homeCoordinator = HomeCoordinator(
            navigationController: UINavigationController(),
            viewController: homeViewController
        )
        
        // CenterButtonTapped 클로저 전달
        homeCoordinator.centerButtonTapped = { [weak homeCoordinator] in
                    homeCoordinator?.routeToCreateAppointment()
                }
        
        homeCoordinator.start()
        homeCoordinator.parentCoordinator = self
        childCoordinators.append(homeCoordinator)
        
        let myPageReactor = MyPageReactor(
            fetchUserInfoUsecase: FetchUserInfoUsecase(
                repository: FetchUserInfoRepository(
                    remoteDataSource: RemoteFetchUserInfoDataSource()
                )
            )
        )
        
        let myPageViewController = MyPageViewController(reactor: myPageReactor)
        let myPageCoordinator = MyPageCoordinator(
            navigationController: UINavigationController(),
            viewController: myPageViewController
        )
        myPageCoordinator.start()
        myPageCoordinator.parentCoordinator = self
        childCoordinators.append(myPageCoordinator)
        
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
        
        // Set delegates
//        homeNavController.delegate = self
//        myPageNavController.delegate = self
    }
    
    // UINavigationControllerDelegate 메서드 오버라이드
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let tabBarController = navigationController.tabBarController {
            let isRootViewController = navigationController.viewControllers.first == viewController
            tabBarController.tabBar.isHidden = !isRootViewController
        }
    }
}

extension MainTabBarCoordinator {
    private func setRoute() {
        self.viewController.sendRoutingEvent = { [weak self] event in
            switch event {
            case .createAppointment:
                self?.handleCenterButtonTap()
            }
        }
    }
    
    /// Deeplink route to detail
    public func routeToInviteScene(with meetId: MeetID) {
        if let homeCoordinator = childCoordinators.first as? HomeCoordinator {
            homeCoordinator.routeToInviteScene(with: meetId)
        }
    }
    
    private func handleCenterButtonTap() {
        // guard let selectedIndex = self.viewController.selectedIndex else { return }
        let selectedIndex = self.viewController.selectedIndex
        
        if selectedIndex == 0, let homeCoordinator = childCoordinators[selectedIndex] as? HomeCoordinator {
            homeCoordinator.centerButtonTapped?()
        } else if selectedIndex == 1, let myPageCoordinator = childCoordinators[selectedIndex] as? MyPageCoordinator {
            print("마이페이지에서 centerButtonTapped 이벤트 발생!")
            // myPageCoordinator.centerButtonTapped?()
        }
    }
}
