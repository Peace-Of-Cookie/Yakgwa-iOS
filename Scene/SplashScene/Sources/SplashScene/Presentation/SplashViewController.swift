//
//  SplashViewController.swift
//
//
//  Created by Ekko on 7/10/24.
//

import UIKit

import CoreKit
import SnapKit
import ReactorKit

public final class SplashViewController: UIViewController, View {
    public typealias Reactor = SplashReactor
    
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - UI Components
    fileprivate let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    private lazy var splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash_image", in: .module, with: nil)
        return imageView
    }()
    // MARK: - Initializers
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorView.startAnimating()
        
        setUI()
    }
    
    // MARK: - Privates
    private func setUI() {
        self.view.backgroundColor = .primary300
        
        self.view.addSubview(activityIndicatorView)
        self.activityIndicatorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.view.addSubview(splashImageView)
        splashImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
    public func bind(reactor: Reactor) {
    }
}

#Preview {
    SplashViewController(reactor: SplashReactor())
}
