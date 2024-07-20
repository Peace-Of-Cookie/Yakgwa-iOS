//
//  MyVotedLocationView.swift
//
//
//  Created by Ekko on 7/20/24.
//

import UIKit

import CoreKit

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
        view.backgroundColor = .neutral200
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var revoteButton: YakGwaButton = {
        let button = YakGwaButton(style: .secondary, image: .rightArrowBlack)
        button.title = "장소 다시 투표하기"
        return button
    }()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        
        setUI()
        test()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() {
        
    }
    
    private func setUI() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(stackContainer)
        stackContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()

        }
        
        stackContainer.addSubview(locationStack)
        locationStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.addSubview(revoteButton)
        revoteButton.snp.makeConstraints {
            $0.top.equalTo(locationStack.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func test() {
        let locationView = LocationView()
        locationStack.addArrangedSubview(locationView)
        
        let locationView2 = LocationView()
        locationStack.addArrangedSubview(locationView2)
    }
}

public final class LocationView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
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
        label.font = .m14
        label.textColor = .neutral600
        return label
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
        self.addSubview(locationLabel)
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(locationLabel)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
}

#Preview {
    MyVotedLocationView()
}
