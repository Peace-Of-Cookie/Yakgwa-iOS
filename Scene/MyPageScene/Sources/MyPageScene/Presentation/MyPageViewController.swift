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
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "마이페이지"
        label.font = .sb18
        return label
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var profileContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .neutralWhite
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var myLocationMenu: MenuView = MenuView(title: "나의 장소", description: "마음에 드는 장소를 미리 찾아보고 저장해요")
    
    private lazy var historyMenu: MenuView = MenuView(title: "약속 히스토리", description: "지금까지 있었던 약속들을 모아서 볼 수 있어요")
    
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
        // profileImage.image = UIImage(named: "profile_default", in: .module, with: nil)
    }
}

// MARK: - Privates
extension MyPageViewController {
    
}

#Preview {
    MyPageViewController()
}
