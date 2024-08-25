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
import Data

import DetailScene

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
            case .detail(let id):
                self?.routeToAppointmentDetailScene(with: id)
            }
        }
    }
}

extension InviteCoordinator {
    private func routeToAppointmentDetailScene(with id: MeetID) {
        let fetchAppointmentUsecase: FetchAppointmentDetailUsecaseProtocol = FetchAppointmentDetailUsecase(
            repository: FetchAppointmentDetailRepository(
                remoteDataSource: RemoteFetchAppointmentDetailDataSource()
            )
        )
        
        let fetchMyVoteLocationsUsecase: FetchMyVoteLocationsUsecaseProtocol = FetchMyVoteLocationsUsecase(
            repository: FetchMyVoteLocationsRepository(
                remoteDataSource: RemoteFetchMyVoteLocationsDataSource()
            )
        )

        
        let reactor = AppointmentDetailViewReactor(
            id: id,
            fetchAppointmentDetailUsecase: fetchAppointmentUsecase,
            fetchMyVoteLocationsUsecase: fetchMyVoteLocationsUsecase
        )
        
        let viewController = AppointmentDetailViewController(reactor: reactor)
        
        if let navigationController = self.navigationController {
            
            var viewControllers = navigationController.viewControllers
            
            if let index = viewControllers.firstIndex(of: self.viewController) {
                viewControllers.remove(at: index)
            }
            
            navigationController.viewControllers = viewControllers
            
            let coordinator = AppointmentDetailCoordinator(
                navigationController: navigationController,
                viewController: viewController
            )
            
            // TODO: - 코디네이터 메모리 관리 체크 필요
            
            navigationController.delegate = self
            coordinator.parentCoordinator = self
            coordinator.start()
            addChildCoordinator(coordinator)
        }
    }
}
