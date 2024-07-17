//
//  SplashCoordinator.swift
//  
//
//  Created by Ekko on 7/10/24.
//

import UIKit

import CoreKit
import Util

import RxSwift

import LoginScene
import Network

public final class SplashCoordinator: Coordinator {

    // MARK: - Properties
    public var navigationController: UINavigationController?
    public var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    // let reactor: SplashReactor
    let viewController: SplashViewController
    
    // MARK: - Initializers
    public init(
        window: UIWindow,
        viewController: SplashViewController
    ) {
        self.window = window
        self.viewController = viewController
        
        self.viewController.delegate = self
    }
    
    // MARK: - Functions
    public func start() {
        self.window.rootViewController = self.viewController
        self.window.makeKeyAndVisible()
    }
}

extension SplashCoordinator: SplashSceneDelegate {
    public func presentLoginScene() {
        let kakaoLoginService: KakaoLoginService = KakaoLoginService(apiDataSource: BaseRemoteDataSource<LoginAPI>())
        
        let loginUsecase: LoginUseCaseProtocol = LoginUseCase(loginService: kakaoLoginService)
        
        let reactor: LoginReactor = LoginReactor(loginUseCase: loginUsecase)
        
        let loginViewController = LoginViewController(reactor: reactor)
        
        let loginCoordinator = LoginCoordinator (
            window: self.window,
            viewController: loginViewController
        )
        
        loginCoordinator.start()
    }
    
    public func presentMainScene() {
        print("SplashCoordinator - presentMainScene()")
    }
}
