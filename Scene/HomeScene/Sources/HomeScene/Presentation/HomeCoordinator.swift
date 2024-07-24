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

public final class HomeCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: HomeViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: HomeViewController
    ) {
        self.viewController = viewController
        super.init(navigationController: navigationController)
    }
    // MARK: - Public
    public override func start() {
        self.viewController.sendRoutingEvent = { [weak self] event in
            switch event {
            case .create:
                self?.routeToCreateAppointment()
            }
        }
        
        self.navigationController?.viewControllers = [self.viewController]
    }
    
    // MARK: - Private
    
    // MARK: - Public
}

extension HomeCoordinator {
    private func routeToCreateAppointment() {
        let inputAppointmentInfoViewController = InputAppointmentInfoViewController()
        if let navigationController = self.navigationController {
            let inputAppointmentInfoCoordinator = InputAppointmentInfoCoordinator(
                navigationController: navigationController,
                viewController: inputAppointmentInfoViewController
            )
            navigationController.delegate = self
        
            inputAppointmentInfoCoordinator.parentCoordinator = self
            inputAppointmentInfoCoordinator.start()
            addChildCoordinator(inputAppointmentInfoCoordinator)
        }
    }
}
