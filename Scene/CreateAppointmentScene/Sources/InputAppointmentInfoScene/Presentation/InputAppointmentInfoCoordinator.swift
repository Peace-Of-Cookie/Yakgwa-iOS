//
//  InputAppointmentInfoCoordinator.swift
//
//
//  Created by Ekko on 7/23/24.
//

import UIKit

import CoreKit
import Util

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
    }
    // MARK: - Private
}
