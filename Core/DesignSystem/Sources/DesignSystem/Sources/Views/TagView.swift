//
//  TagView.swift
//
//
//  Created by Ekko on 7/11/24.
//

import UIKit

import SnapKit
import RxSwift

/// 테크 뷰
public final class TagView: UIView {
    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .sb14
        label.textColor = UIColor.secondary700
        return label
    }()
    
    public init(tag: String) {
        super.init(frame: .zero)
        tagLabel.text = tag
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.borderColor = UIColor.secondary700.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        
        addSubview(tagLabel)
        
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(6)
            $0.leading.equalTo(12)
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

public extension Reactive where Base: TagView {
    var text: Binder<String?> {
        return Binder(self.base) { tagView, text in
            tagView.tagLabel.text = text
        }
    }
}
