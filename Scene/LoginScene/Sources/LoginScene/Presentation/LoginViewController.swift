//
//  LoginViewController.swift
//
//
//  Created by Ekko on 7/10/24.
//

import UIKit

import SnapKit

public class LoginViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setUI()
    }
    
    private func setUI() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

#Preview {
    LoginViewController()
}
