//
//  Font.swift
//  
//
//  Created by Ekko on 7/10/24.
//

import UIKit

public enum Font {
    
    public enum Name {
        case pretendardBlack
        case pretendardBold
        case pretendardExtraBold
        case pretendardExtraLight
        case pretendardLight
        case pretendardMedium
        case pretendardRegular
        case pretendardSemiBold
        case pretendardThin
        
        var fileName: String {
            switch self {
            case .pretendardBlack: return "Pretendard-Black"
            case .pretendardBold: return "Pretendard-Bold"
            case .pretendardExtraBold: return "Pretendard-ExtraBold"
            case .pretendardExtraLight: return "Pretendard-ExtraLight"
            case .pretendardLight: return "Pretendard-Light"
            case .pretendardMedium: return "Pretendard-Medium"
            case .pretendardRegular: return "Pretendard-Regular"
            case .pretendardSemiBold: return "Pretendard-SemiBold"
            case .pretendardThin: return "Pretendard-Thin"
            }
        }
        
        var name: String {
            switch self {
            case .pretendardBlack: return "Pretendard-Black"
            case .pretendardBold: return "Pretendard-Bold"
            case .pretendardExtraBold: return "Pretendard-ExtraBold"
            case .pretendardExtraLight: return "Pretendard-ExtraLight"
            case .pretendardLight: return "Pretendard-Light"
            case .pretendardMedium: return "Pretendard-Medium"
            case .pretendardRegular: return "Pretendard-Regular"
            case .pretendardSemiBold: return "Pretendard-SemiBold"
            case .pretendardThin: return "Pretendard-Thin"
                
            }
        }
    }

    public enum Size: CGFloat {
        case _10 = 10
        case _11 = 11
        case _12 = 12
        case _14 = 14
        case _16 = 16
        case _18 = 18
        case _20 = 20
        case _24 = 24
    }
    
    public enum Extension: String {
        case ttf
        case otf
    }
    
    public struct YakgwaFont {
        private let _name: Name
        private let _extension: Extension
        
        init(name: Name = .pretendardRegular, extensions: Extension = .otf) {
            self._name = name
            self._extension = extensions
        }
        
        var name: String {
            "\(_name.name)"
        }
        
        var fileName: String {
            "\(_name.fileName)"
        }

        var `extension`: String {
            _extension.rawValue
        }
    }
    
    /// 폰트 파일 등록
    /// - 앱 초기에 최초 한 번 실행됩니다.
    public static func registerYakgwaFont() {
        let fonts: [YakgwaFont] = [
            YakgwaFont(name: .pretendardBlack),
            YakgwaFont(name: .pretendardBold),
            YakgwaFont(name: .pretendardExtraBold),
            YakgwaFont(name: .pretendardExtraLight),
            YakgwaFont(name: .pretendardLight),
            YakgwaFont(name: .pretendardMedium),
            YakgwaFont(name: .pretendardRegular),
            YakgwaFont(name: .pretendardSemiBold),
            YakgwaFont(name: .pretendardThin)
        ]
        
        for font in fonts {
            Font.registerFont(fontName: font.fileName, fontExtension: font.extension)
        }
    }
    
}

extension Font {
    
    /// 폰트 파일 등록
    /// - Parameters:
    ///   - fontName: 등록할 폰트 파일의 이름
    ///   - fontExtension: 등록할 폰트 파일의 확장자
    static func registerFont(fontName: String, fontExtension: String) {
        
        let bundle: Bundle = Bundle.module
        
        guard let fontURL = bundle.url(forResource: fontName,
                                       withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName).\(fontExtension)")
        }
        
        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }
        
        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
        
    }
}

