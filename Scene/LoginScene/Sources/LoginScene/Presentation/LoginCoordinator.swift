//
//  LoginCoordinator.swift
//
//
//  Created by Ekko on 7/13/24.
//

import UIKit

import CoreKit
import Util
import Domain
import Data

import MainScene
import DetailScene



protocol SceneFlowDelegate {
    func presentMainScene()
}

public final class LoginCoordinator: BaseCoordinator {
    // MARK: - Properties
    // public var navigationController: UINavigationController?
    // public var childCoordinators: [Coordinator] = []
    private let window: UIWindow

    let viewController: LoginViewController
    
    // MARK: - Initializers
    public init(
        window: UIWindow,
        viewController: LoginViewController
    ) {
        self.window = window
        self.viewController = viewController
        super.init(navigationController: UINavigationController(rootViewController: self.viewController))
    }
    
    // MARK: - Functions
    public override func start() {
        navigationController?.navigationBar.isHidden = true
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }
}

extension LoginCoordinator {
    public func routeToDetailScene(with id: MeetID) {
        guard let navigationController = self.navigationController else {
            print("Error: NavigationController is not set.")
            return
        }
        let fetchAppointmentUsecase: FetchAppointmentDetailUsecaseProtocol = FetchAppointmentDetailUsecase(
            repository: FetchAppointmentDetailRepository(
                remoteDataSource: RemoteFetchAppointmentDetailDataSource()
            )
        )
        let reactor = AppointmentDetailViewReactor(
            id: id,
            fetchAppointmentDetailUsecase: fetchAppointmentUsecase
        )
        
        let viewController = AppointmentDetailViewController(reactor: reactor)
        
        let coordinator = AppointmentDetailCoordinator(
            navigationController: self.navigationController ?? UINavigationController(),
            viewController: viewController
        )
        
        navigationController.delegate = self
        coordinator.parentCoordinator = self
        coordinator.start()
        addChildCoordinator(coordinator)
    }
}
