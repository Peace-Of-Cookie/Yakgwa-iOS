//
//  ConfirmLocationView.swift
//  DetailScene
//
//  Created by Kim Dongjoo on 9/26/24.
//

import UIKit

import CoreKit
import Domain

public final class ConfirmLocationView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sb14
        label.textColor = .neutralBlack
        label.text = "약속 장소"
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .m14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .m11
        label.textColor = .neutral600
        return label
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .neutralWhite
        self.layer.cornerRadius = 25
        
        [titleLabel, locationLabel, addressLabel].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Functions
    func configure(with entity: VoteLocationInfo) {
        let location = entity.getPlaceInfo()
        if let title = location.first?.getTitle() {
            locationLabel.text = title
        }
        
        if let address = location.first?.getAddress() {
            addressLabel.text = address
        }
    }
}
