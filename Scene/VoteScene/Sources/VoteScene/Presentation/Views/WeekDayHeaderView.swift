//
//  WeekDayHeaderView.swift
//
//
//  Created by Ekko on 7/20/24.
//

import UIKit

final class WeekdayHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "WeekdayHeaderView"
    
    private let weekdayLabels: [UILabel] = {
        let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
        return weekdays.map { weekday in
            let label = UILabel()
            label.text = weekday
            label.textAlignment = .center
            label.textColor = weekday == "일" ? .red : (weekday == "토" ? .blue : .neutralBlack)
            label.font = .m11
            return label
        }
    }()
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral200
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: weekdayLabels)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

