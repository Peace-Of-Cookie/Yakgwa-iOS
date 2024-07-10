//
//  Coordinator.swift
//
//
//  Created by Ekko on 7/10/24.
//

import UIKit

public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

public extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
