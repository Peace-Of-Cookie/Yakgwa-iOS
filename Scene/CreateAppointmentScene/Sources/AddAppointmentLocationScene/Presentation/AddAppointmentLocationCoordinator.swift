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
import Data

import AddCandidateLocationScene
import DetailScene

public final class AddAppointmentLocationCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: AddAppointmentLocationViewController
    public var onLocationsSelected: (([Location]) -> Void)?
    
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
                self?.navigationController?.popViewController(animated: true)
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
            repository: FetchLocationRepository(
                remoteDataSource: RemoteFetchLocationsDataSource()
            )
        )
        let reactor = AddCandinateLocationReactor(
            fetchLocationUsecase: fetchLocationUsecase,
            previousScene: .createAppointment
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
        
        let fetchDateCandidatesUsecase: FetchDateCandidatesUsecaseProtocol = FetchDateCandidatesUsecase(
            repository: FetchDateCandidatesRepository(
                remoteDataSource: RemoteFetchDateCandidatesDataSource()
            )
        )
        
        let reactor = AppointmentDetailViewReactor(
            id: id,
            fetchAppointmentDetailUsecase: fetchAppointmentUsecase,
            fetchMyVoteLocationsUsecase: fetchMyVoteLocationsUsecase,
            fetchDateCandidatesUsecase: fetchDateCandidatesUsecase
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
}
