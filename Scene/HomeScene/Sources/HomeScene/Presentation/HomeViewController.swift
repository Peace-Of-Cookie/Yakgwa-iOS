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
    private lazy var testLabel: UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.font = .h3
        return label
    }()
    
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
        
        self.view.backgroundColor = .neutral300
        setUI()
    }
    
    // MARK: - Privates
    private func setUI() {
        view.addSubview(testLabel)
        testLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

#Preview {
    HomeViewController()
}