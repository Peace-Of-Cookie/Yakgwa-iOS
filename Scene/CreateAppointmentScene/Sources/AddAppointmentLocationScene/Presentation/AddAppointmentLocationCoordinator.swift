//
//  InputAppointmentInfoCoordinator.swift
//
//
//  Created by Kim Dongjoo on 8/5/24.
//

import UIKit

import CoreKit
import Util
import Domain

public final class AddAppointmentLocationCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: AddAppointmentLocationViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: AddAppointmentLocationViewController
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
        
    }
}

extension AddAppointmentLocationCoordinator {
    private func routeToDetail() {
    }
}
