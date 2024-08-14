//
//  LocationViewModel.swift
//
//
//  Created by Kim Dongjoo on 8/6/24.
//

import Foundation
import Domain

public struct LocationViewModel: Equatable {
    let title: String
    let address: String
    var isBookMark: Bool = false
    var isSelected: Bool = false
}

extension LocationViewModel {
    init(with entity: Location, isSelected: Bool = false) {
        self.title = entity.title ?? ""
        if let roadAddress = entity.roadAddress, !roadAddress.isEmpty {
            self.address = roadAddress
        } else {
            self.address = entity.address ?? ""
        }
        self.isSelected = isSelected
    }
    
}
