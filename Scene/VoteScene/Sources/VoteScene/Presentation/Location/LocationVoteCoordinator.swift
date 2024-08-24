//
//  LocationVoteCoordinator.swift
//
//
//  Created by Ekko on 8/24/24.
//

import UIKit

import CoreKit
import Util
import Domain

public final class LocationVoteCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: LocationVoteViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: LocationVoteViewController
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
                print("뒤로 가기")
            case .addCandindate:
                print("후보 추가 화면")
            }
        }
    }
}

extension LocationVoteCoordinator {
    
}
