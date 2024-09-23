//
//  CreateBottomSheetButton.swift
//  DesignSystem
//
//  Created by Kim Dongjoo on 9/23/24.
//

import UIKit
import RxSwift
import RxCocoa

public final class CreateBottomSheetButton: UIView {
    // MARK: - Properties
    private let backButtonTappedSubject = PublishRelay<Void>()
    private let nextButtonTappedSubject = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    private lazy var backButton: YakGwaButton = {
        let button = YakGwaButton(style: .secondary)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: YakGwaButton = {
        let button = YakGwaButton(style: .primary)
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        
        attribute()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() {
        self.backButton.title = "이전"
        self.nextButton.title = "다음으로"
    }
    
    private func setUI() {
        self.backgroundColor = .neutralWhite
        self.layer.applySketchShadow(color: .neutral600, alpha: 0.2, x: 0, y: -1, blur: 20, spread: 0)
        
        self.addSubview(backButton)
        self.addSubview(nextButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalToSuperview().multipliedBy(1.0 / 3.0).offset(-20)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(backButton.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalToSuperview().multipliedBy(2.0 / 3.0).offset(-20)
        }
    }
        // MARK: - Actions
    @objc
    private func backButtonPressed() {
        backButtonTappedSubject.accept(())
    }
    
    @objc
    private func nextButtonPressed() {
        nextButtonTappedSubject.accept(())
    }
    
    public var back_rx_tap: Observable<Void> {
        return backButtonTappedSubject.asObservable()
    }
    
    public var next_rx_tap: Observable<Void> {
        return nextButtonTappedSubject.asObservable()
    }
}

public extension Reactive where Base: CreateBottomSheetButton {
    var back_rx_tap: ControlEvent<Void> {
        return ControlEvent(events: base.back_rx_tap)
    }
    
    var next_rx_tap: ControlEvent<Void> {
        return ControlEvent(events: base.next_rx_tap)
    }
}
