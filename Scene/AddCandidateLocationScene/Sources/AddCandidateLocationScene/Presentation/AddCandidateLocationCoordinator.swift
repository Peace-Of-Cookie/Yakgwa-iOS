//
//  AddCandidateLocationCoordinator.swift
//
//
//  Created by Kim Dongjoo on 9/11/24.
//

import UIKit

import CoreKit
import Util
import Domain

public final class AddCandidateLocationCoordinator: BaseCoordinator {
    // MARK: - Properties
    let viewController: AddCandidateLocationViewController
    public var onLocationsSelected: (([Location]) -> Void)?
    
    // MARK: - Initilizers
    public init(
        navigationController: UINavigationController,
        viewController: AddCandidateLocationViewController
    ) {
        self.viewController = viewController
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Pulbic
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
            case .add(let locations):
                self?.routeToAddAppointmentLocationScene(with: locations)
            }
        }
    }
}

extension AddCandidateLocationCoordinator {
    private func routeToAddAppointmentLocationScene(with locations: [Location]) {
        self.onLocationsSelected?(locations)
        self.navigationController?.popViewController(animated: true)
    }
}

