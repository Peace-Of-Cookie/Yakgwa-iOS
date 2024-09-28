//
//  MyVotedLocationView.swift
//
//
//  Created by Ekko on 7/20/24.
//

import UIKit

import CoreKit
import Domain

public final class MyVotedLocationView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 투표한 장소"
        label.font = .sb14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var stackContainer: UIView = { 
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var revoteButton: YakGwaButton = {
        let button = YakGwaButton(style: .secondary, image: .rightArrowBlack)
        button.title = "장소 다시 투표하기"
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
    private func attribute() {
        
    }
    
    private func setUI() {
        self.backgroundColor = .neutralWhite
        self.layer.cornerRadius = 25
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(stackContainer)
        stackContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()

        }
        
        stackContainer.addSubview(locationStack)
        locationStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.addSubview(revoteButton)
        revoteButton.snp.makeConstraints {
            $0.top.equalTo(stackContainer.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

extension MyVotedLocationView {
    public func configure(with viewModel: VoteLocationInfo) {
        self.locationStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let locationInfo = viewModel.getPlaceInfo()
        
        for location in locationInfo {
            let locationView = LocationView(with: location)
            
            locationStack.addArrangedSubview(locationView)
        }
    }
}

public final class LocationView: UIView {
    // MARK: - Properties
    let viewModel: VoteLocationInfo.PlaceInfo
    
    // MARK: - UI Components
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "장소명"
        label.font = .m14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "강서구 강서로"
        label.font = .m11
        label.textColor = .neutral600
        return label
    }()
    
    // MARK: - Initializers
    public init(with viewModel: VoteLocationInfo.PlaceInfo) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setUI()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() {
        locationLabel.text = viewModel.getTitle()

        let address = viewModel.getAddress() ?? ""
        descriptionLabel.text = address
        descriptionLabel.isHidden = address.isEmpty
    }
    
    private func setUI() {
        self.backgroundColor = .neutral200
        self.layer.cornerRadius = 15
        
        self.addSubview(stack)
        stack.addArrangedSubview(locationLabel)
        stack.addArrangedSubview(descriptionLabel)
                
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
}

#Preview {
    MyVotedLocationView()
}
