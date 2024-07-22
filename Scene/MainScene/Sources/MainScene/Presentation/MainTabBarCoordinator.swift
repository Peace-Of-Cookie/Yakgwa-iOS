//
//  MainTabBarCoordinator.swift
//
//
//  Created by Ekko on 7/22/24.
//

import UIKit

import CoreKit
import Util

public final class MainTabBarCoordinator: Coordinator {
    // MARK: - Properties
    public var navigationController: UINavigationController?
    public var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    let viewController: MainTabBarController
    
    // MARK: - Initializers
    public init(
        window: UIWindow,
        viewController: MainTabBarController
    ) {
        self.window = window
        self.viewController = viewController
    }
    
    // MARK: - Public
    public func start() {
        self.window.rootViewController = self.viewController
        self.window.makeKeyAndVisible()
    }
}
