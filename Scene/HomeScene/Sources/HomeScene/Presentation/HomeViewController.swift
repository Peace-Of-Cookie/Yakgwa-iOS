//
//  HomeViewController.swift
//
//
//  Created by Kim Dongjoo on 7/10/24.
//

import UIKit
import CoreKit

import SnapKit

public class HomeViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var yakgwaLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "yakgwa_label_icon", in: .module, with: nil)
        // image.backgroundColor = .systemRed
        return image
    }()
    
    private lazy var alarmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell_icon", in: .module, with: nil), for: .normal)
        return button
    }()
    
    private lazy var appointmentView: AppointmentView = {
        let view = AppointmentView()
        return view
    }()
    
    private lazy var noAppointmentView: NoAppointmentView = {
        let view = NoAppointmentView()
        return view
    }()
    
    private var homeCollectionView: UICollectionView!
    
    // MARK: - Initializers
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .neutral200
        setUI()
    }
    
    // MARK: - Privates
    private func setUI() {
        view.addSubview(alarmButton)
        alarmButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(yakgwaLogo)
        yakgwaLogo.snp.makeConstraints {
            $0.centerY.equalTo(alarmButton)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(noAppointmentView)
        noAppointmentView.snp.makeConstraints {
            $0.top.equalTo(yakgwaLogo.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
        
    }
}

#Preview {
    HomeViewController()
}
