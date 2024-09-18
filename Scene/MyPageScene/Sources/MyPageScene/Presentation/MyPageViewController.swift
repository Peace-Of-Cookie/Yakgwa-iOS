//
//  MyPageViewController.swift
//
//
//  Created by Ekko on 7/22/24.
//

import UIKit

import CoreKit

public final class MyPageViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var sceneTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "마이페이지"
        label.font = .sb18
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var myPageStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var profileContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "default_profile_image", in: .module, with: nil)
        return view
    }()
    
    private lazy var profileLabelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "{이름}님"
        label.font = .sb16
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다"
        label.font = .m16
        label.textColor = .neutralBlack
        return label
    }()
    
    // MARK: - Initializers
    public init() {
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
    
    private func setUI() {
        self.view.backgroundColor = .neutral200
        
        self.view.addSubview(sceneTitleLabel)
        sceneTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.view.addSubview(profileContainer)
        
    }
}

// MARK: - Privates
extension MyPageViewController {
    
}
