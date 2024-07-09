//
//  AppColor.swift
//  
//
//  Created by Kim Dongjoo on 7/9/24.
//

import UIKit

/// Yakgwa에서 사용되는 Color 집합
public enum AppColor: String {
    // Primary
    case primary100 = "Primary_100"
    case primary300 = "Primary_300"
    case primary600 = "Primary_600"
    case primary700 = "Primary_700"
    case primary800 = "Primary_800"
    
    // Neutral
    case neutral200 = "Neutral_200"
    case neutral300 = "Neutral_300"
    case neutral500 = "Neutral_500"
    case neutral600 = "Neutral_600"
    case neutral700 = "Neutral_700"
    case neutral800 = "Neutral_800"
    case neutralBlack = "Neutral_Black"
    case neutralWhite = "Neutral_White"
    
    // Secondary
    case secondary700 = "Secondary_700"
    
    public static func setColor(_ appColor: AppColor) -> UIColor {
        guard let palleteColor = UIColor(named: appColor.rawValue, in: Bundle.module, compatibleWith: nil) else {
            return UIColor.clear
        }
        return palleteColor
    }

    /// cgColor
    public static func setColor(_ appColor: AppColor) -> CGColor {
        guard let palleteColor = UIColor(named: appColor.rawValue, in: Bundle.module, compatibleWith: nil) else {
            return UIColor.clear.cgColor
        }
        return palleteColor.cgColor
    }
}
