//
//  Scene.swift
//
//
//  Created by Ekko on 7/13/24.
//

import UIKit

public protocol Scene {
    var viewController: UIViewController { get }
}

public extension Scene where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
}
