//
//  LocationView.swift
//
//
//  Created by Ekko on 7/19/24.
//

import UIKit

final class LocationView: UIView {
    // MARK: - Properties
    private var name: String = ""
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = name
        return label
    }()
    
    // MARK: - Initializers
    init(
        name: String
    ) {
        self.name = name
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
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(16)
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
