//
//  MenuView.swift
//
//
//  Created by Ekko on 9/18/24.
//

import UIKit

import CoreKit
import Domain

public final class MenuView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .m16
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .r10
        label.textColor = .neutral600
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "forward_icon", in: .module, with: nil)
        return imageView
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
        self.layer.cornerRadius = 25
        
        self.addSubview(labelStack)
        labelStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(descriptionLabel)
        
        self.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(labelStack)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(20)
        }
    }
    
    // MARK: - Publics
    func configure(title: String, description: String = "") {
        titleLabel.text = title
        descriptionLabel.text = description
        descriptionLabel.isHidden = description.isEmpty
    }
}
