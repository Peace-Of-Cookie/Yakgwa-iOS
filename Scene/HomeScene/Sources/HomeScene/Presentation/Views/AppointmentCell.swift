//
//  AppointmentCell.swift
//
//
//  Created by Ekko on 7/12/24.
//

import UIKit

public final class AppointmentCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "AppointmentCell"
    
    // MARK: - UI Components
    private lazy var appointmentView: AppointmentView = {
        let view = AppointmentView()
        return view
    }()
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    public func setUI() {
        contentView.addSubview(appointmentView)
        appointmentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
