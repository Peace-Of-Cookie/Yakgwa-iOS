//
//  InviteCoordinator.swift
//  
//
//  Created by Kim Dongjoo on 8/23/24.
//

import UIKit

import CoreKit
import Util
import Domain

public final class InviteCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: InviteViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: InviteViewController
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
