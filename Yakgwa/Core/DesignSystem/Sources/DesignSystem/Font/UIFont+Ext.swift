//
//  UIFont+Ext.swift
//  
//
//  Created by Kim Dongjoo on 7/9/24.
//

import UIKit

extension UIFont {
    /// Bold, 24
    public static var h1: UIFont {
        return .pretendard(size: ._24, weight: .bold)
    }
    
    public static var h2: UIFont {
        return .pretendard(size: ._20, weight: .semibold)
    }
    
    public static var h3: UIFont {
        return .pretendard(size: ._18, weight: .semibold)
    }
    
    public static var sb18: UIFont {
        return .pretendard(size: ._18, weight: .semibold)
    }
    
    public static var sb16: UIFont {
        return .pretendard(size: ._16, weight: .semibold)
    }
    
    public static var m16: UIFont {
        return .pretendard(size: ._16, weight: .medium)
    }
    
    public static var r16: UIFont {
        return .pretendard(size: ._16, weight: .regular)
    }
    
    public static var sb14: UIFont {
        return .pretendard(size: ._14, weight: .semibold)
    }
    
    public static var m14: UIFont {
        return .pretendard(size: ._14, weight: .medium)
    }
    
    public static var r14: UIFont {
        return .pretendard(size: ._14, weight: .regular)
    }
    
    public static var sb12: UIFont {
        return .pretendard(size: ._12, weight: .semibold)
    }
    
    public static var m12: UIFont {
        return .pretendard(size: ._12, weight: .medium)
    }
    
    public static var r12: UIFont {
        return .pretendard(size: ._12, weight: .regular)
    }
    
    public static var m11: UIFont {
        return .pretendard(size: ._11, weight: .medium)
    }
    
    public static var r10: UIFont {
        return .pretendard(size: ._10, weight: .regular)
    }
}

extension UIFont {
    public static func pretendard(size: Font.Size, weight: UIFont.Weight) -> UIFont {
        var font = Font.YakgwaFont()
        switch weight {
        case .black:
            font = Font.YakgwaFont(name: .pretendardBlack)
        case .bold:
            font = Font.YakgwaFont(name: .pretendardBold)
        case .semibold:
            font = Font.YakgwaFont(name: .pretendardSemiBold)
        case .medium:
            font = Font.YakgwaFont(name: .pretendardMedium)
        case .light:
            font = Font.YakgwaFont(name: .pretendardLight)
        case .thin:
            font = Font.YakgwaFont(name: .pretendardThin)
        case .ultraLight:
            font = Font.YakgwaFont(name: .pretendardExtraLight)
        case .heavy:
            font = Font.YakgwaFont(name: .pretendardExtraBold)
        case .regular:
            font = Font.YakgwaFont(name: .pretendardRegular)
        default:
            font = Font.YakgwaFont(name: .pretendardRegular)
        }
        
        return ._font(name: font.name, size: size.rawValue)
    }
    
    public static func _font(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }
}
