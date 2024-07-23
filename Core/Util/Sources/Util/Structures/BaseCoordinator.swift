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
    private var parentCoordinator: Coordinator?
    
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
        // 이동 전 ViewController
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        // fromViewController가 navigationController의 viewControllers에 포함되어있으면 return. 왜냐하면 여기에 포함되어있지 않아야 현재 fromViewController 가 사라질 화면을 의미.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        // child coordinator 가 일을 끝냈다고 알림.
        removeAllChildCoordinators()
        navigationController.popViewController(animated: true)
        parentCoordinator?.removeChildCoordinator(self)
    }
}
