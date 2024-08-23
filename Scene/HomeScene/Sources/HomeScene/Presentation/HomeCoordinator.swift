//
//  HomeCoordinator.swift
//
//
//  Created by Ekko on 7/22/24.
//

import UIKit

import CoreKit
import Util
import Domain
import Data

import InputAppointmentInfoScene
import DetailScene
import InviteScene

public final class HomeCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: HomeViewController
    
    public var centerButtonTapped: (() -> Void)?
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: HomeViewController
    ) {
        self.viewController = viewController
        super.init(navigationController: navigationController)
    }
    // MARK: - Public
    public override func start() {
        setRoute()
        setCenterButtonAction()
        
        self.navigationController?.viewControllers = [self.viewController]
    }
    
    // MARK: - Private
    private func setRoute() {
        self.viewController.sendRoutingEvent = { [weak self] event in
            switch event {
            case .create:
                self?.routeToCreateAppointment()
            case .detail(let id):
                self?.routeToAppointmentDetailScene(with: id)
            }
        }
    }
    
    private func setCenterButtonAction() {
        self.centerButtonTapped = { [weak self] in
            self?.routeToCreateAppointment()
        }
    }
    // MARK: - Public
}

extension HomeCoordinator {
    public func routeToCreateAppointment() {
        let reactor = InputAppointmentReactor()
        let inputAppointmentInfoViewController = InputAppointmentInfoViewController(reactor: reactor)
        if let navigationController = self.navigationController {
            let inputAppointmentInfoCoordinator = InputAppointmentInfoCoordinator(
                navigationController: navigationController,
                viewController: inputAppointmentInfoViewController
            )
            navigationController.delegate = self
        
            inputAppointmentInfoCoordinator.parentCoordinator = self
            inputAppointmentInfoCoordinator.start()
            addChildCoordinator(inputAppointmentInfoCoordinator)
        }
        
        inputAppointmentInfoViewController.tabBarController?.tabBar.isHidden = true
    }
    
    public func routeToAppointmentDetailScene(with id: MeetID) {
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
        
        if let navigationController = self.navigationController {
            let coordinator = AppointmentDetailCoordinator(
                navigationController: navigationController,
                viewController: viewController
            )
            
            navigationController.delegate = self
            coordinator.parentCoordinator = self
            coordinator.start()
            addChildCoordinator(coordinator)
        }
    }
    
    public func routeToInviteScene(with id: MeetID) {
        let fetchAppointmentUsecase: FetchAppointmentDetailUsecaseProtocol = FetchAppointmentDetailUsecase(
            repository: FetchAppointmentDetailRepository(
                remoteDataSource: RemoteFetchAppointmentDetailDataSource()
            )
        )
        
        let reactor = InviteReactor(
            id: id,
            fetchAppointmentDetailUsecase: fetchAppointmentUsecase
        )
        
        let viewController = InviteViewController(reactor: reactor)
        
        if let navigationController = self.navigationController {
            let coordinator = InviteCoordinator(
                navigationController: navigationController,
                viewController: viewController
            )
            
            navigationController.delegate = self
            coordinator.parentCoordinator = self
            coordinator.start()
            addChildCoordinator(coordinator)
        }
        
        viewController.tabBarController?.tabBar.isHidden = true
    }
}
