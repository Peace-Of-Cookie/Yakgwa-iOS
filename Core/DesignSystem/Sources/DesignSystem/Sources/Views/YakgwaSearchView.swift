//
//  YakgwaSearchTest.swift
//
//
//  Created by Ekko on 8/5/24.
//

import UIKit

import Util

public final class YakgwaSearchView: UIView {
    // MARK: - Properties
    public var returnValueAction: ((String) -> Void)?
    public var didChangeTextAction: ((String) -> Void)?
    
    public var imageString: String = ""
    
    // MARK: - UI Components
    private lazy var containerView: UIView = {
        let textField = UIView()
        textField.backgroundColor = .neutralWhite
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral500
        label.font = .r14
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // MARK: - Initializers
    public init(
        placeholder: String,
        image: String = "search_icon"
    ) {
        self.imageString = image
        
        super.init(frame: .zero)
        
        self.titleLabel.text = placeholder
        
        attribute()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() {
        self.button.setImage(UIImage(named: imageString, in: .module, with: nil), for: .normal)
    }
    
    private func setUI() {
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
    }
}
