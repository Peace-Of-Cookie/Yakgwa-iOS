//
//  InputAppointmentInfoCoordinator.swift
//
//
//  Created by Kim Dongjoo on 8/5/24.
//

import UIKit

import CoreKit
import Util
import Domain

import AddCandinateLocationScene
import DetailScene

public final class AddAppointmentLocationCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: AddAppointmentLocationViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: AddAppointmentLocationViewController
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
            case .search:
                self?.routeToAddCandinateLocationScene()
            }
        }
    }
}

extension AddAppointmentLocationCoordinator {
    private func routeToAddCandinateLocationScene() {
        let fetchLocationUsecase: FetchLocationsUsecaseProtocol = FetchLocationsUsecase(
            repository: AddCandinateLocationRepository(
                remoteDataSource: RemoteFetchLocationsDataSource()
            )
        )
        let reactor = AddCandinateLocationReactor(fetchLocationUsecase: fetchLocationUsecase)
        let viewController = AddCandinateLocationViewController(reactor: reactor)
        
        if let navigationController = self.navigationController {
            let coordinator = AddCandinateLocationCoordinator(
                navigationController: navigationController,
                viewController: viewController
            )
            
            navigationController.delegate = self
            coordinator.parentCoordinator = self
            coordinator.onLocationsSelected = { [weak self] locations in
                self?.viewController.reactor?.action.onNext(.returnToScene(locations))
            }
            coordinator.start()
            addChildCoordinator(coordinator)
        }
        
        viewController.tabBarController?.tabBar.isHidden = true
    }
    
    private func routeToAppointmentDetailScene(with id: MeetID) {
        let reactor = AppointmentDetailViewReactor(id: id)
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
}
