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
    }
    
    // MARK: - Functions
    public func start() {
        self.window.rootViewController = self.viewController
        self.window.makeKeyAndVisible()
    }
}
