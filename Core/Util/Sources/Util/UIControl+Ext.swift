//
//  UIControl+Ext.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//
import UIKit

public extension UIControl {
    func addAction(
        for controlEvents: UIControl.Event = .touchUpInside,
        _ closure: @escaping Closure
    ) {
        let sleeve = ClosureSleeve(closure)
        self.addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(
            self,
            String(format: "[%d]", arc4random()),
            sleeve,
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        )
    }
}
