//
//  UIDevice+Ext.swift
//
//
//  Created by Kim Dongjoo on 7/11/24.
//

import UIKit

public extension UIDevice {
    var safeAreaTopHeight: CGFloat {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.safeAreaInsets.top ?? 0
    }

    var safeAreaBottomHeight: CGFloat {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.safeAreaInsets.bottom ?? 0
    }
}
