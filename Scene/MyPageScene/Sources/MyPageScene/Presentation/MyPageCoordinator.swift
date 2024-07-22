//
//  MyPageCoordinator.swift
//
//
//  Created by Ekko on 7/22/24.
//

import UIKit

import CoreKit
import Util


public final class MyPageCoordinator: Coordinator {
    // MARK: - Properties
    public var navigationController: UINavigationController?
    public var childCoordinators: [Coordinator] = []
    
    let viewController: MyPageViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: MyPageViewController
    ) {
        self.navigationController = navigationController
        self.viewController = viewController
    }
    
    // MARK: - Functions
    public func start() {
        self.navigationController?.viewControllers = [self.viewController]
    }
}
