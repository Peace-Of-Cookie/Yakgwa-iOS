//
//  TimeSlotCell.swift
//
//
//  Created by Ekko on 7/20/24.
//

import UIKit

class TimeSlotCell: UICollectionViewCell {
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .m12
        label.textColor = .neutral700
        label.textAlignment = .center
        return label
    }()
    
    let boxView: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral300
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        contentView.addSubview(boxView)
        boxView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(2)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(52)
            $0.height.equalTo(36)
        }
        
        boxView.layer.cornerRadius = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

