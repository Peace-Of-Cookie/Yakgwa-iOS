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
import InviteScene

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
    public func routeToInviteScene(with id: MeetID) {
        guard let navigationController = self.navigationController else {
            print("Error: NavigationController is not set.")
            return
        }
        let fetchAppointmentUsecase: FetchAppointmentDetailUsecaseProtocol = FetchAppointmentDetailUsecase(
            repository: FetchAppointmentDetailRepository(
                remoteDataSource: RemoteFetchAppointmentDetailDataSource()
            )
        )
        
        let joinAppointmentUsecase: JoinAppointmentUsecaseProtocol = JoinAppointmentUsecase(
            repository: JoinAppointmentRepository(
                remoteDataSource: RemoteJoinAppoinementDataSource()
            )
        )
        
        let reactor = InviteReactor(
            id: id,
            fetchAppointmentDetailUsecase: fetchAppointmentUsecase,
            joinAppointmentUsecase: joinAppointmentUsecase
        )
        
        let viewController = InviteViewController(reactor: reactor)
        
        let coordinator = InviteCoordinator(
            navigationController: self.navigationController ?? UINavigationController(),
            viewController: viewController
        )
        
        navigationController.delegate = self
        coordinator.parentCoordinator = self
        coordinator.start()
        addChildCoordinator(coordinator)
        
        viewController.tabBarController?.tabBar.isHidden = true
    }
}
