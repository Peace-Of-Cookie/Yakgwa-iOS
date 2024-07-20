//
//  ProfileView.swift
//
//
//  Created by Ekko on 7/19/24.
//

import UIKit

/// 모임 참가자 아이콘
public final class ProfileView: UIView {
    // MARK: - Properties
    /// 새로 들어온 모임원
    private var isNew: Bool = true
    
    // MARK: - UI Components
    private lazy var isNewView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "yakgwa_icon", in: .module, with: nil)
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "default_profile_icon", in: .module, with: nil)
        return image
    }()
    
    // MARK: - Initializers
    public init(
        isNew: Bool = false
    ) {
        self.isNew = isNew
        super.init(frame: .zero)
        
        attribute()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() {
        isNewView.isHidden = !isNew
    }
    
    private func setUI() {
        addSubview(iconImageView)
        addSubview(isNewView)
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        isNewView.snp.makeConstraints {
            $0.width.height.equalTo(14)
            $0.top.equalTo(iconImageView)
            $0.leading.equalTo(iconImageView)
        }
    }
}

#Preview {
    ProfileView()
}
