//
//  AddAppointmentLocationCoordinator.swift
//
//
//  Created by Ekko on 8/15/24.
//

import UIKit

import CoreKit
import Util
import Domain

public final class AppointmentDetailCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: AppointmentDetailViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: AppointmentDetailViewController
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
            }
        }
    }
}
