//
//  AppointmentCell.swift
//
//
//  Created by Ekko on 7/12/24.
//

import UIKit

import Domain

import RxSwift

public final class AppointmentCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "AppointmentCell"
    
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - UI Components
    lazy var appointmentView: AppointmentView = {
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
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .clear
        
        contentView.addSubview(appointmentView)
        appointmentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Publics
    public func configure(with viewModel: AppointmentDetailViewModel) {
        appointmentView.configure(with: viewModel)
    }
}
