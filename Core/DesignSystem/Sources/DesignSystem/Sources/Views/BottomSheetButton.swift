//
//  BottomSheetButton.swift
//
//
//  Created by Ekko on 7/18/24.
//

import UIKit

public final class BottomSheetButton: UIView {
    // MARK: - Properties
    private var title: String
    
    // MARK: - UI Components
    private lazy var button: YakGwaButton = {
        let button = YakGwaButton(style: .primary)
        return button
    }()
    
    // MARK: - Initializers
    public init(
        title: String = "다음으로"
    ) {
        self.title = title
        super.init(frame: .zero)
        
        attribute()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() {
        self.button.title = self.title
    }
    
    private func setUI() {
        self.backgroundColor = .neutralWhite
        self.layer.applySketchShadow(color: .neutral600, alpha: 0.2, x: 0, y: -1, blur: 20, spread: 0)
        
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

#Preview {
    BottomSheetButton()
}
