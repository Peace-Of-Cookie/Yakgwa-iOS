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
    
    private lazy var myPlaceMenuView: MenuView = {
        let view = MenuView()
        view.configure(title: "나의 장소", description: "마음에 드는 장소를 미리 찾아보고 저장해요")
        return view
    }()
    
    private lazy var historyMenuView: MenuView = {
        let view = MenuView()
        view.configure(title: "나의 장소", description: "마음에 드는 장소를 미리 찾아보고 저장해요")
        return view
    }()
    
    private lazy var privacyPolicyMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var privacyPolicyMenuStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var privacyPolicyLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보처리방침"
        label.font = .m12
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var termsOfUseLabel: UILabel = {
        let label = UILabel()
        label.text = "이용약관"
        label.font = .m12
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
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(sceneTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        self.contentView.addSubview(myPageStack)
        myPageStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        myPageStack.addArrangedSubview(profileContainer)
        
        self.profileContainer.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(56)
            $0.top.leading.equalTo(16)
            $0.centerY.equalToSuperview()
        }
        
        self.profileContainer.addSubview(profileLabelStack)
        profileLabelStack.addArrangedSubview(nameLabel)
        profileLabelStack.addArrangedSubview(welcomeLabel)
        
        profileLabelStack.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        myPageStack.addArrangedSubview(myPlaceMenuView)
        myPageStack.addArrangedSubview(historyMenuView)
        
        privacyPolicyMenuView.addSubview(privacyPolicyMenuStack)
        privacyPolicyMenuStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.center.equalToSuperview()
        }
        
        privacyPolicyMenuStack.addArrangedSubview(privacyPolicyLabel)
        privacyPolicyMenuStack.addArrangedSubview(termsOfUseLabel)
        
        myPageStack.addArrangedSubview(privacyPolicyMenuView)
        
    }
}

// MARK: - Privates
extension MyPageViewController {
    
}
