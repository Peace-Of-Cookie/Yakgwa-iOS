//
//  FetchThemeRepositoryProtocol.swift
//
//
//  Created by Kim Dongjoo on 8/1/24.
//

import Network
import RxSwift

public protocol FetchThemeRepositoryProtocol {
    func fetchThemes() -> Single<[Theme]>
}
