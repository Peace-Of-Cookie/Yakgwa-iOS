//
//  DateVoteCoordinator.swift
//
//
//  Created by Ekko on 8/24/24.
//

import UIKit

import CoreKit
import Util
import Domain

public final class DateVoteCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: DateVoteViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: DateVoteViewController
    ) {
        self.viewController = viewController
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Public
    public override func start() {
        self.navigationController?.pushViewController(self.viewController, animated: true)
        self.setRoute()
    }
    
    // MARK: - Privates
    private func setRoute() {
        self.viewController.sendRoutingEvent = { [weak self] event in
            switch event {
            case .back:
                self?.navigationController?.popViewController(animated: true)
            
            }
        }
    }
}

extension DateVoteCoordinator {
}
