//
//  MyPageCoordinator.swift
//
//
//  Created by Ekko on 7/22/24.
//

import UIKit

import CoreKit
import Util


public final class MyPageCoordinator: BaseCoordinator {
    // MARK: - Properties
//    public var navigationController: UINavigationController?
//    public var childCoordinators: [Coordinator] = []
    
    let viewController: MyPageViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: MyPageViewController
    ) {
        self.viewController = viewController
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Functions
    public override func start() {
        self.navigationController?.viewControllers = [self.viewController]
    }
}
