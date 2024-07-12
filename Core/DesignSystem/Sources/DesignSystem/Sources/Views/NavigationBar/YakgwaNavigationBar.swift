//
//  YakgwaNavigationBar.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import UIKit
import Util

public protocol YakgwaNavigationBarDelegate: AnyObject {
    func didTapRightButton()
}

public final class YakgwaNavigationBar: UIView {
    // MARK: - Properties
    public weak var delegate: YakgwaNavigationBarDelegate?
    
    private let horizontalInset: CGFloat = 16
    
    // MARK: - UI Components
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yakgwa_logo", in: .module, with: nil)
        return imageView
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    public convenience init(
        title: String?,
        rightButtonImage: UIImage?,
        rightButtonText: String? = nil
    ) {
        self.init()
        self.rightButton.setImage(rightButtonImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(horizontalInset)
        }
        
        self.addSubview(rightButton)
        rightButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-horizontalInset)
        }
    }
    
    @objc
    private func rightButtonTapped() {
        delegate?.didTapRightButton()
    }
}

#Preview {
    YakgwaNavigationBar(
        title: nil,
        rightButtonImage: UIImage(named: "alarm_icon", in: .module, with: nil)
    )
}
