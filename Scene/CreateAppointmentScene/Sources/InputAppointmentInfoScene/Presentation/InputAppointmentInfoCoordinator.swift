//
//  InputAppointmentInfoCoordinator.swift
//
//
//  Created by Ekko on 7/23/24.
//

import UIKit

import CoreKit
import Util
import SelectAppointmentThemeScene

public final class InputAppointmentInfoCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: InputAppointmentInfoViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: InputAppointmentInfoViewController
    ) {
        self.viewController = viewController
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Public
    public override func start() {
        self.navigationController?.pushViewController(self.viewController, animated: true)
        self.setRoute()
    }
    
    // MARK: - Private
    private func setRoute() {
        self.viewController.sendRoutingEvent = { [weak self] event in
            switch event {
            case .back:
                print("뒤로 가기")
            case .theme(let newAppointment):
                self?.routeSelectAppointmentTheme(with: newAppointment)
            }
        }
    }
}

extension InputAppointmentInfoCoordinator {
    private func routeSelectAppointmentTheme(with newAppointment: NewAppointment) {
        let selectAppointmentThemeViewController = SelectAppointmentThemeViewController()
        if let navigationController = self.navigationController {
            let selectAppointmentThemeCoordinator = SelectAppointmentThemeCoordinator(
                navigationController: navigationController,
                viewController: selectAppointmentThemeViewController
            )
            navigationController.delegate = self
            selectAppointmentThemeCoordinator.parentCoordinator = self
            selectAppointmentThemeCoordinator.start()
            addChildCoordinator(selectAppointmentThemeCoordinator)
        }
        
        selectAppointmentThemeViewController.tabBarController?.tabBar.isHidden = true
    }
}
