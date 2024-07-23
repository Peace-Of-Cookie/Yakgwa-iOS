//
//  LoginCoordinator.swift
//
//
//  Created by Ekko on 7/13/24.
//

import UIKit

import CoreKit
import Util

import MainScene

protocol SceneFlowDelegate {
    func presentMainScene()
}

public final class LoginCoordinator: Coordinator {
    // MARK: - Properties
    public var navigationController: UINavigationController?
    public var childCoordinators: [Coordinator] = []
    private let window: UIWindow

    let viewController: LoginViewController
    
    // MARK: - Initializers
    public init(
        window: UIWindow,
        viewController: LoginViewController
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
