//
//  LoginViewController.swift
//
//
//  Created by Ekko on 7/10/24.
//

import UIKit

import CoreKit

import SnapKit
import ReactorKit
import RxCocoa

public protocol LoginSceneDelegate: AnyObject {
    func loginSceneToMainScene()
}

public class LoginViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public weak var delegate: LoginSceneDelegate?
    
    // MARK: - UI Components
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_title", in: .module, with: nil)
        return imageView
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakao_login_button", in: .module, with: nil), for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    public init(
        reactor: LoginReactor
    ) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setUI()
    }
    
    // MARK: - Privates
    private func setUI() {
        view.backgroundColor = .neutralWhite
        
        view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(104)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(kakaoLoginButton)
        kakaoLoginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-32)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    public func bind(reactor: LoginReactor) {
        // Action
        kakaoLoginButton.rx.tap
            .map { Reactor.Action.kakaoLogin }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map { $0.isLoggedIn }
            .distinctUntilChanged()
            .filter { $0 }
            .subscribe(onNext: {[weak self] _ in
                self?.delegate?.loginSceneToMainScene()
            })
            .disposed(by: disposeBag)
    }
}
