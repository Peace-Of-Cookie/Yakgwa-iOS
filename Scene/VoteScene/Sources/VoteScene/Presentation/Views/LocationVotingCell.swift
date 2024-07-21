//
//  LocationVotingCell.swift
//
//
//  Created by Ekko on 7/21/24.
//

import UIKit

import CoreKit

final class LocationVotingCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "LocationVotingCell"
    
    // MARK: - UI Components
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "장소명"
        label.font = .m14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "주소"
        label.font = .m11
        label.textColor = .neutral700
        return label
    }()
    
    private lazy var profileStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private lazy var profileImageStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = -8
        return stack
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "+N명"
        label.font = .m12
        label.textColor = .neutral800
        label.isHidden = true
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setProfileStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .neutral200
        self.layer.cornerRadius = 15
        
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        containerView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        containerView.addSubview(profileStack)
        profileStack.addArrangedSubview(profileImageStack)
        profileStack.addArrangedSubview(numberLabel)
        
        profileStack.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
#warning("TODO : - UI Test ")
    private func setProfileStack() {
        let count = 6
        if count > 5 {
            numberLabel.isHidden = false
            for _ in 0..<5 {
                let profileView = ProfileView(isNew: false)
                profileImageStack.addArrangedSubview(profileView)
            }
        } else {
            for _ in 0..<count {
                let profileView = ProfileView(isNew: false)
                profileImageStack.addArrangedSubview(profileView)
            }
        }
        
    }
}
