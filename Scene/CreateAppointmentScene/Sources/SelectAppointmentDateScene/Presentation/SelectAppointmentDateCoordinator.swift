//
//  SelectAppointmentCoordinator.swift
//
//
//  Created by Kim Dongjoo on 8/2/24.
//

import UIKit

import CoreKit
import Util

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
        
    }
}
