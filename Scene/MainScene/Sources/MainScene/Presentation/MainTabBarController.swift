//
//  MainTabBarController.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import UIKit

import ReactorKit
import CoreKit
import Util
import RxCocoa

public final class MainTabBarController: UITabBarController, View {
    // MARK: - Properties
    public var disposeBag = DisposeBag()
    
    // MARK: - Initializers
    public init(
        reactor: MainTabBarViewReactor
    ) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        let tabBar = MainTabBar()
        tabBar.customDelegate = self
        self.setValue(tabBar, forKey: "tabBar")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Privates
    public func bind(reactor: MainTabBarViewReactor) {
        print("bind")
    }
}

extension MainTabBarController: MainTabBarDelegate {
    func centerButtonTapped() {
        print("약속 생성 화면으로 이동")
    }
}

#Preview {
    MainTabBarController(reactor: MainTabBarViewReactor())
}
