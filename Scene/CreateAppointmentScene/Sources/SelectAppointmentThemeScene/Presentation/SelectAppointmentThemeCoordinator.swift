//
//  SelectAppointmentThemeCoordinator.swift
//
//
//  Created by Kim Dongjoo on 7/31/24.
//

import UIKit

import CoreKit
import Util
// import SelectAppointmentDateScene

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
        
    }
}
