//
//  YakgwaPopUpView.swift
//
//
//  Created by Kim Dongjoo on 8/14/24.
//

import UIKit
import RxSwift
import RxCocoa

public final class YakgwaPopUpView: UIView {
    // MARK: - Properties
    private let descriptionString: String
    private let firstButtonTitle: String
    private let secondButtonTitle: String
    
    private let firstButtonTappedSubject = PublishRelay<Void>()
    private let secondButtonTappedSubject = PublishRelay<Void>()
    
    // MARK: - UI Components
    private lazy var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .neutralWhite
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .sb14
        label.textColor = .neutralBlack
        label.textAlignment = .center
        return label
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var firstButton: YakGwaButton = {
        let button = YakGwaButton(style: .popupFirst)
        button.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondButton: YakGwaButton = {
        let button = YakGwaButton(style: .popupSecond)
        button.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    public init(
        description: String,
        firstButtonTitle: String = "",
        secondButtonTitle: String = ""
    ) {
        self.descriptionString = description
        self.firstButtonTitle = firstButtonTitle
        self.secondButtonTitle = secondButtonTitle
        super.init(frame: .zero)
        
        attribute()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func attribute() {
        self.descriptionLabel.text = self.descriptionString
        
        if secondButtonTitle.isEmpty {
            secondButton.isHidden = true
        } else {
            secondButton.isHidden = false
            self.secondButton.title = self.secondButtonTitle
        }
        
        self.firstButton.title = self.firstButtonTitle
    }
    
    private func setUI() {
        self.backgroundColor = .clear
        
        self.addSubview(dimView)
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.width.equalTo(328)
            $0.center.equalToSuperview()
        }
        
        containerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalTo(16)
            $0.centerX.equalToSuperview()
        }
        
        containerView.addSubview(buttonStack)
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        buttonStack.addArrangedSubview(firstButton)
        buttonStack.addArrangedSubview(secondButton)
    }
    // MARK: - Public
    
    // MARK: - Actions
    @objc
    private func firstButtonTapped() {
        firstButtonTappedSubject.accept(())
    }
    
    @objc
    private func secondButtonTapped() {
        secondButtonTappedSubject.accept(())
    }
    
    public var rx_tapFirstButton: Observable<Void> {
        return firstButtonTappedSubject.asObservable()
    }
    
    public var rx_tapSecondButton: Observable<Void> {
        return secondButtonTappedSubject.asObservable()
    }
}

public extension Reactive where Base: YakgwaPopUpView {
    var firstButtonTap: ControlEvent<Void> {
        return ControlEvent(events: base.rx_tapFirstButton)
    }
    
    var secondButtonTap: ControlEvent<Void> {
        return ControlEvent(events: base.rx_tapSecondButton)
    }
}
