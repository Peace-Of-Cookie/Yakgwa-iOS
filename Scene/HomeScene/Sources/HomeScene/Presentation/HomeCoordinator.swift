//
//  HomeCoordinator.swift
//
//
//  Created by Ekko on 7/22/24.
//

import UIKit

import CoreKit
import Util

import InputAppointmentInfoScene

public final class HomeCoordinator: NSObject, Coordinator {
    // MARK: - Properties
    public var navigationController: UINavigationController?
    public var childCoordinators: [Coordinator] = []
    
    let viewController: HomeViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: HomeViewController
    ) {
        self.navigationController = navigationController
        self.viewController = viewController
    }
    // MARK: - Public
    public func start() {
        self.navigationController?.viewControllers = [self.viewController]
    }
    
    // MARK: - Private
}
