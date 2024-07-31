//
//  Reactive+Ext.swift
//
//
//  Created by Kim Dongjoo on 7/31/24.
//

import UIKit

import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    var viewDidAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear(_:)))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}
