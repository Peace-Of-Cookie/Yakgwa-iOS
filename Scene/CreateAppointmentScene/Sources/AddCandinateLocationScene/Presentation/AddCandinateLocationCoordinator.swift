//
//  AddCandinateLocationCoordinator.swift
//
//
//  Created by Kim Dongjoo on 8/6/24.
//

import UIKit

import CoreKit
import Util

public final class AddCandinateLocationCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: AddCandinateLocationViewController
    
    // MARK: - Initilizers
    public init(
        navigationController: UINavigationController,
        viewController: AddCandinateLocationViewController
    ) {
        self.viewController = viewController
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Pulbic
    public override func start() {
        self.navigationController?.pushViewController(self.viewController, animated: true)
        self.setRoute()
    }
    
    // MARK: - Private
    private func setRoute() {
        
    }
}
