//
//  AddAppointmentLocationViewController.swift
//
//
//  Created by Ekko on 7/17/24.
//

import UIKit

import CoreKit

public final class AddAppointmentLocationViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var navigationBar: YakgwaNavigationDetailBar = {
        let nav = YakgwaNavigationDetailBar()
        nav.delegate = self
        nav.configure(previousTitle: "약속 만들기")
        return nav
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약속 장소 후보를 추가해 주세요"
        label.font = .m14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 3개 추가 기능"
        label.font = .m11
        label.textColor = .neutral600
        return label
    }()
    
    private lazy var yakgwaSwitchView: YakgwaSwitchView = {
        let view = YakgwaSwitchView()
        view.delegate = self
        return view
    }()
    
    private lazy var bottomSheetButton: BottomSheetButton = {
        let button = BottomSheetButton(title: "다음으로")
        return button
    }()
    
    private lazy var searchTextField: YakgwaSearchTextField = {
        let textField = YakgwaSearchTextField(placeholder: "지역/지하철역을 검색해주세요")
        return textField
    }()
    
    private lazy var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    // MARK: - Initializers
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        setUI()
        addLocationDemo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Privates
    private func setUI() {
        self.view.backgroundColor = .neutral200
        
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.view.addSubview(bottomSheetButton)
        bottomSheetButton.snp.makeConstraints {
            $0.height.equalTo(92)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        self.view.addSubview(yakgwaSwitchView)
        yakgwaSwitchView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(titleStack)
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(descriptionLabel)
        
        titleStack.snp.makeConstraints {
            $0.top.equalTo(yakgwaSwitchView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(locationStack)
        locationStack.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func addLocationDemo() {
        let locationView = LocationView(name: "마곡")
        let locationView2 = LocationView(name: "발산")
    
        locationStack.addArrangedSubview(locationView)
        locationStack.addArrangedSubview(locationView2)
    }
    
    private func changeMode(state: YakgwaSwitchViewState) {
        if state == .first {
            titleLabel.text = "약속 장소 후보를 추가해 주세요"
            descriptionLabel.text = "최대 3개 추가 기능"
            titleStack.addArrangedSubview(descriptionLabel)
        } else {
            titleLabel.text = "정해진 약속 장소를 입력해주세요."
            descriptionLabel.text = ""
            titleStack.removeArrangedSubview(descriptionLabel)
        }
    }
}

extension AddAppointmentLocationViewController: YakgwaNavigationDetailDelegate {
    public func didTapDetailLeftButton() {
        print("didTapDetailLeftButton")
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddAppointmentLocationViewController: YakgwaSwitchViewDelegate {
    public func yakgwaSwitchView(state: YakgwaSwitchViewState) {
        print("yakgwaSwitchMode: \(state)")
        self.changeMode(state: state)
    }
}

#Preview {
    AddAppointmentLocationViewController()
}
