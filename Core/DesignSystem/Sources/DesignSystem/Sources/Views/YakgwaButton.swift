//
//  YakGwaButton.swift
//  
//
//  Created by Ekko on 7/11/24.
//

import UIKit

public enum YakgwaButtonStyle {
    /// 기본
    case primary
    /// 보조
    case secondary
    /// 흰색
    case white
}

public enum YakgwaButtonImage: String {
    case share = "share_icon"
    case rightArrow = "arrow_icon"
    case rightArrowBlack = "arrow_icon_black"
    case plus = "plus_icon"
}

public class YakGwaButton: UIButton {
    
    /// 버튼 타이틀
    public var title: String = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    /// 버튼 이미지 (optional)
    public var buttonImage: UIImage? {
        didSet {
            updateConfiguration()
        }
    }
    
    private var style: YakgwaButtonStyle = .primary
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.attribute()
        self.layout()
        self.updateConfiguration()
    }
    
    public convenience init(style: YakgwaButtonStyle) {
        self.init(frame: .zero)
        switch style {
        case .primary:
            self.backgroundColor = UIColor.primary700
            self.setTitleColor(UIColor.white, for: .normal)
        case .secondary:
            self.backgroundColor = UIColor.primary100
            self.setTitleColor(UIColor.black, for: .normal)
        case .white:
            self.backgroundColor = UIColor.neutralWhite
            self.setTitleColor(UIColor.neutral600, for: .normal)
        }
        
        self.layer.cornerRadius = 15
        self.style = style
    }
    
    public convenience init(
        style: YakgwaButtonStyle,
        image: YakgwaButtonImage
    ) {
        self.init(frame: .zero)
        switch style {
        case .primary:
            self.backgroundColor = UIColor.primary700
            self.setTitleColor(UIColor.white, for: .normal)
            self.buttonImage = UIImage(named: image.rawValue, in: .module, with: nil)
        case .secondary:
            self.backgroundColor = UIColor.primary100
            self.setTitleColor(UIColor.black, for: .normal)
            self.buttonImage = UIImage(named: image.rawValue, in: .module, with: nil)
        case .white:
            self.backgroundColor = UIColor.neutralWhite
            self.setTitleColor(UIColor.neutral600, for: .normal)
            self.buttonImage = UIImage(named: image.rawValue, in: .module, with: nil)
        }
        
        self.layer.cornerRadius = 15
        self.style = style
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func attribute() {
        self.backgroundColor = UIColor.primary700
        self.layer.cornerRadius = 12
        
        self.titleLabel?.font = UIFont.h2
        self.setTitleColor(UIColor.white, for: .normal)
        
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = UIColor.white
        
        if self.style == .secondary {
            self.backgroundColor = UIColor.primary100
            configuration.baseForegroundColor = UIColor.neutralBlack
            self.setTitleColor(UIColor.neutralBlack, for: .normal)
        } else if self.style == .white {
            self.setTitleColor(UIColor.neutral600, for: .normal)
        }
        self.configuration = configuration
    }
    
    public func layout() {
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
    
    public override func updateConfiguration() {
        var configuration = self.configuration ?? UIButton.Configuration.plain()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.sb14
        titleContainer.foregroundColor = style == .primary ? UIColor.white : UIColor.neutralBlack
        
        switch style {
        case .primary:
            titleContainer.foregroundColor = UIColor.white
        case .secondary:
            titleContainer.foregroundColor = UIColor.neutralBlack
        case .white:
            titleContainer.foregroundColor = UIColor.neutral600
        }
        
        configuration.title = title
        configuration.attributedTitle = AttributedString(title, attributes: titleContainer)
        
        configuration.image = buttonImage
        configuration.imagePadding = 6 // 이미지와 타이틀 간의 간격
        configuration.imagePlacement = .trailing // 이미지 위치를 타이틀 오른쪽으로 설정
        self.configuration = configuration
    }
}
