//
//  DateCell.swift
//  
//
//  Created by Ekko on 7/20/24.
//

import UIKit

final class DateCell: UICollectionViewCell {
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .m14
        label.textColor = .neutralBlack
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
