//
//  LocationViewModel.swift
//
//
//  Created by Kim Dongjoo on 8/6/24.
//

import Foundation
import Domain

public struct LocationViewModel {
    let title: String
    let address: String
    let isBookMark: Bool = false
    
    init(with entity: Location) {
        title = entity.title ?? ""
        address = entity.roadAddress ?? ""
    }
}
