//
//  AddAppointmentLocationViewController.swift
//
//
//  Created by Ekko on 7/17/24.
//

import CoreKit

import UIKit

public final class AddAppointmentLocationViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var navigationBar: YakgwaNavigationDetailBar = {
        let nav = YakgwaNavigationDetailBar()
        nav.delegate = self
        nav.configure(previousTitle: "약속 만들기")
        return nav
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약속의 이름이 무엇인가요?"
        label.font = .m14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var titleInputContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var titleInputField: UITextField = {
        let textField = UITextField()
        textField.textColor = .neutralBlack
        textField.font = UIFont.r14
        
        return textField
    }()
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: - Privates
    private func setUI() {
        self.view.backgroundColor = .neutral200
        
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension AddAppointmentLocationViewController: YakgwaNavigationDetailDelegate {
    public func didTapDetailLeftButton() {
        print("didTapDetailLeftButton")
        self.navigationController?.popViewController(animated: true)
    }
}

#Preview {
    AddAppointmentLocationViewController()
}
