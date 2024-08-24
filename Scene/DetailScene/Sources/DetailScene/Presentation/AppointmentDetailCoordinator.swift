//
//  AddAppointmentLocationCoordinator.swift
//
//
//  Created by Ekko on 8/15/24.
//

import UIKit

import CoreKit
import Util
import Domain

import VoteScene

public final class AppointmentDetailCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: AppointmentDetailViewController
    
    // MARK: - Initializers
    public init(
        navigationController: UINavigationController,
        viewController: AppointmentDetailViewController
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
            case .dateVote(let id):
                self?.routeToDateVoteScene(with: id)
            case .locationVote(let id):
                self?.routeToLocationVoteScene(with: id)
            }
        }
    }
}

extension AppointmentDetailCoordinator {
    private func routeToDateVoteScene(with id: MeetID) {
        let reactor: DateVoteReactor = DateVoteReactor(id: id)
        
        let dateVoteViewController: DateVoteViewController = DateVoteViewController(reactor: reactor)
        
        if let navigationController = self.navigationController {
            let dateVoteCoordinator: DateVoteCoordinator = DateVoteCoordinator(
                navigationController: navigationController,
                viewController: dateVoteViewController
            )
            
            navigationController.delegate = self
            dateVoteCoordinator.parentCoordinator = self
            dateVoteCoordinator.start()
            addChildCoordinator(dateVoteCoordinator)
        }
    }
    
    private func routeToLocationVoteScene(with id: MeetID) {
        let reactor: LocationVoteReactor = LocationVoteReactor(id: id)
        
        let locationVoteViewController: LocationVoteViewController = LocationVoteViewController(reactor: reactor)
        
        if let navigationController = self.navigationController {
            let locationVoteCoordinator: LocationVoteCoordinator = LocationVoteCoordinator(
                navigationController: navigationController,
                viewController: locationVoteViewController
            )
            
            navigationController.delegate = self
            locationVoteCoordinator.parentCoordinator = self
            locationVoteCoordinator.start()
            addChildCoordinator(locationVoteCoordinator)
        }
    }
}
