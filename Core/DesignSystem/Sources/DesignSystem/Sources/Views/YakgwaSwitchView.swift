//
//  YakgwaSwitchView.swift
//
//
//  Created by Ekko on 7/18/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

public enum YakgwaSwitchViewState {
    case first
    case second
}

public protocol YakgwaSwitchViewDelegate: AnyObject {
    func yakgwaSwitchView(state: YakgwaSwitchViewState)
}

public final class YakgwaSwitchView: UIView {
    // MARK: - Properties
    private var currentState: YakgwaSwitchViewState = .first
    private var selectedLabel: UILabel?
    public  weak var delegate: YakgwaSwitchViewDelegate?
    
    // MARK: - UI Components
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 40
        return stack
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "후보 추가"
        label.font = .sb14
        label.textAlignment = .center
        label.textColor = .neutralWhite
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "직접 입력"
        label.font = .sb14
        label.textAlignment = .center
        label.textColor = .neutral600
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let selectionIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary800
        view.layer.cornerRadius = 6
        return view
    }()
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setupGestureRecognizers()
        selectLabel(firstLabel, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.neutral300.cgColor
        
        self.addSubview(selectionIndicatorView)
        self.addSubview(stack)
        self.stack.addArrangedSubview(firstLabel)
        self.stack.addArrangedSubview(secondLabel)
        
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(22)
            $0.centerX.centerY.equalToSuperview()
        }
        
        selectionIndicatorView.snp.makeConstraints {
            $0.top.equalTo(firstLabel).offset(-8)
            $0.leading.equalTo(firstLabel).offset(-16)
            $0.centerX.centerY.equalTo(firstLabel)
        }
    }

    private func setupGestureRecognizers() {
        let firstLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
        firstLabel.addGestureRecognizer(firstLabelTapGesture)
        
        let secondLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
        secondLabel.addGestureRecognizer(secondLabelTapGesture)
    }
    
    @objc
    private func handleLabelTap(_ gesture: UITapGestureRecognizer) {
        guard let tappedLabel = gesture.view as? UILabel else { return }
        selectLabel(tappedLabel, animated: true)
        
    }
    
    private func selectLabel(_ label: UILabel, animated: Bool) {
        if label == selectedLabel { return }
        
        selectedLabel = label
        updateSelectionIndicatorPosition(animated: animated)
        
        firstLabel.textColor = label == firstLabel ? .neutralWhite : .neutral600
        secondLabel.textColor = label == secondLabel ? .neutralWhite : .neutral600
        
        delegate?.yakgwaSwitchView(state: label == firstLabel ? .first : .second)
    }
    
    private func updateSelectionIndicatorPosition(animated: Bool) {
        guard let selectedLabel = selectedLabel else { return }
        selectionIndicatorView.snp.remakeConstraints {
            $0.top.equalTo(selectedLabel).offset(-8)
            $0.leading.equalTo(selectedLabel).offset(-16)
            $0.centerX.centerY.equalTo(selectedLabel)
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
            })
        } else {
            self.layoutIfNeeded()
        }
    }
}

#Preview {
    YakgwaSwitchView()
}
