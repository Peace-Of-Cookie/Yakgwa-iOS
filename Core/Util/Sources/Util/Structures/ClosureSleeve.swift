//
//  ClosureSleeve.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import Foundation

public typealias Closure = () -> Void

class ClosureSleeve {
    let closure: Closure

    init(_ closure: @escaping Closure) {
        self.closure = closure
    }

    @objc func invoke() {
        closure()
    }
}
