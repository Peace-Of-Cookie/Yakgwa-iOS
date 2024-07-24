//
//  BaseCoordinator.swift
//
//
//  Created by Ekko on 7/23/24.
//

import UIKit

@MainActor
open class BaseCoordinator: NSObject, Coordinator {
    open var navigationController: UINavigationController?
    open var childCoordinators: [Coordinator] = []
    open weak var parentCoordinator: Coordinator?
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    open func start() {
        fatalError("start() method should be implemented.")
    }
    
    public func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    public func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    public func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

extension BaseCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        self.removeAllChildCoordinators()
    }
}
