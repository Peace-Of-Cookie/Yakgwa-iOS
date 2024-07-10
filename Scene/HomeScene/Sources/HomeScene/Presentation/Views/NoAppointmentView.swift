//
//  NoAppointmentView.swift
//
//
//  Created by Kim Dongjoo on 7/11/24.
//

import UIKit

import CoreKit
import SnapKit

public class NoAppointmentView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var yakgwaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yakgwa", in: .module, with: nil)
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 약속이 없어요"
        label.font = .m16
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var createButton: YakGwaButton = {
        let button = YakGwaButton()
        button.title = "약속 만들러 가기"
        return button
    }()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .neutralWhite
        
        self.snp.makeConstraints {
            $0.width.equalTo(308)
            $0.height.equalTo(256)
        }
        
        self.layer.cornerRadius = 16
        
        addSubview(createButton)
        createButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(createButton.snp.top).offset(-16)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(yakgwaImageView)
        yakgwaImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

#Preview {
    NoAppointmentView()
}
