//
//  SelectAppointmentCoordinator.swift
//
//
//  Created by Kim Dongjoo on 8/2/24.
//

import UIKit

import CoreKit
import Util
import Domain

import AddAppointmentLocationScene

public final class SelectAppointmentDateCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: SelectAppointmentDateViewController
    
    // MARK: - Initializes
    public init(
        navigationController: UINavigationController,
        viewController: SelectAppointmentDateViewController
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
            case .location(let newAppointment):
                self?.routeToAppointmentLocationScene(with: newAppointment)
            }
        }
    }
}

extension SelectAppointmentDateCoordinator {
    private func routeToAppointmentLocationScene(with newAppointment: NewAppointment) {
        let reactor = AddAppointmentLocationReactor(
            newAppointment: newAppointment
        )
        
        let addAppointmentLocationViewController = AddAppointmentLocationViewController(
            reactor: reactor
        )
        
        if let navigationController = self.navigationController {
            let addAppointmentLocationCoordinator = AddAppointmentLocationCoordinator(
                navigationController: navigationController,
                viewController: addAppointmentLocationViewController
            )
            
            navigationController.delegate = self
            addAppointmentLocationCoordinator.parentCoordinator = self
            addAppointmentLocationCoordinator.start()
            addChildCoordinator(addAppointmentLocationCoordinator)
        }
        
        addAppointmentLocationViewController.tabBarController?.tabBar.isHidden = true
    }
}
