//
//  MyPageCoordinator.swift
//
//
//  Created by Ekko on 7/22/24.
//

import UIKit

import CoreKit
import Util
import Domain
import Data

import InputAppointmentInfoScene

public final class MyPageCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: MyPageViewController
    
    public var centerButtonTapped: (() -> Void)?
    
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
        setRoute()
        self.navigationController?.viewControllers = [self.viewController]
    }
    
    // MARK: - Private
    private func setRoute() {
        self.viewController.sendRoutingEvent = { [weak self] event in
            switch event {
            case .create:
                self?.routeToCreateAppointment()
            }
        }
    }
}

extension MyPageCoordinator {
    public func routeToCreateAppointment() {
        let reactor = InputAppointmentReactor()
        let inputAppointmentInfoViewController = InputAppointmentInfoViewController(reactor: reactor)
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
        
        inputAppointmentInfoViewController.tabBarController?.tabBar.isHidden = true
    }
}
