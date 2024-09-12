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
import Data

import AddCandidateLocationScene

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
                self?.navigationController?.popViewController(animated: true)
            case .addCandindate:
                self?.routeToAddCandinateLocationScene()
            }
        }
    }
}

extension LocationVoteCoordinator {
    private func routeToAddCandinateLocationScene() {
        let fetchLocationUsecase: FetchLocationsUsecaseProtocol = FetchLocationsUsecase(
            repository: FetchLocationRepository(
                remoteDataSource: RemoteFetchLocationsDataSource()
            )
        )
        let reactor = AddCandinateLocationReactor(
            fetchLocationUsecase: fetchLocationUsecase,
            previousScene: .voteLocation
        )
        let viewController = AddCandidateLocationViewController(reactor: reactor)
        
        if let navigationController = self.navigationController {
            let coordinator = AddCandidateLocationCoordinator(
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
}
