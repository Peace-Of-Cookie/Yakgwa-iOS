//
//  SelectAppointmentThemeCoordinator.swift
//
//
//  Created by Kim Dongjoo on 7/31/24.
//

import UIKit

import CoreKit
import Util
import Domain

import SelectAppointmentDateScene

public final class SelectAppointmentThemeCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: SelectAppointmentThemeViewController
    
    // MARK: - Initializes
    public init(
        navigationController: UINavigationController,
        viewController: SelectAppointmentThemeViewController
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
            case .date(let newAppointment):
                self?.routeToSelectAppointmentDateScene(with: newAppointment)
            }
        }
    }
}

extension SelectAppointmentThemeCoordinator {
    private func routeToSelectAppointmentDateScene(with newAppointment: NewAppointment) {
        let reactor = SelectAppointmentDateReactor(newAppointment: newAppointment)
        let selectAppointmentDateViewController = SelectAppointmentDateViewController(reactor: reactor)
        if let navigationController = self.navigationController {
            let selectAppointmentDateCoordinator = SelectAppointmentDateCoordinator(
                navigationController: navigationController,
                viewController: selectAppointmentDateViewController
            )
            navigationController.delegate = self
        
            selectAppointmentDateCoordinator.parentCoordinator = self
            selectAppointmentDateCoordinator.start()
            addChildCoordinator(selectAppointmentDateCoordinator)
        }
        
        selectAppointmentDateViewController.tabBarController?.tabBar.isHidden = true
    }
}
