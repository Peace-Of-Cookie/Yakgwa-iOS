//
//  AppCoordinator.swift
//  Yakgwa
//
//  Created by Ekko on 7/23/24.
//

import UIKit

import CoreKit
import Util
import Network

import SplashScene
import MainScene
import LoginScene

final class AppCoordinator: Coordinator {
    // MARK: - Properties 
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Functions
    func start() {
        presentSplashScene()
        // presentMainScene()
    }
}

extension AppCoordinator {
    /// Splash 화면 이동
    private func presentSplashScene() {
        self.childCoordinators = []
        
        let splashReactor = SplashReactor()
        
        let splashViewController = SplashViewController(reactor: splashReactor)
        splashViewController.delegate = self
        
        let splashCoordinator = SplashCoordinator (
            window: self.window,
            viewController: splashViewController
        )
        
        splashCoordinator.start()
        childCoordinators.append(splashCoordinator)
    }
    
    /// Login 화면 이동
    private func presentLoginScene() {
        self.childCoordinators = []
        
        let kakaoLoginService: KakaoLoginService = KakaoLoginService(apiDataSource: BaseRemoteDataSource<LoginAPI>())
        
        let loginUsecase: LoginUseCaseProtocol = LoginUseCase(loginService: kakaoLoginService)
        
        let reactor: LoginReactor = LoginReactor(loginUseCase: loginUsecase)
        
        let loginViewController = LoginViewController(reactor: reactor)
        loginViewController.delegate = self
        
        let loginCoordinator = LoginCoordinator (
            window: self.window,
            viewController: loginViewController
        )
        
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
    /// Main 화면 이동
    private func presentMainScene() {
        self.childCoordinators = []
        
        let reactor: MainTabBarViewReactor = MainTabBarViewReactor()
        
        let mainTabBarViewController = MainTabBarController(reactor: reactor)
        
        let mainTabBarCoordinator = MainTabBarCoordinator (
            window: self.window,
            viewController: mainTabBarViewController
        )
        
        mainTabBarCoordinator.start()
        childCoordinators.append(mainTabBarCoordinator)
    }
}

extension AppCoordinator: SplashSceneDelegate {
    func routeToLoginScene() {
        self.presentLoginScene()
    }
    func routeToMainScene() {
        self.presentMainScene()
    }
}

extension AppCoordinator: LoginSceneDelegate {
    func loginSceneToMainScene() {
        self.presentMainScene()
    }
}
