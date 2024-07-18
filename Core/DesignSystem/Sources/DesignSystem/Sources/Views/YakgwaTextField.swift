//
//  YakgwaTextField.swift
//
//
//  Created by Ekko on 7/17/24.
//

import UIKit

import Util

final public class YakgwaTextField: UIView {
    // MARK: - Properties
    /// 최대 입력 가능 글자수
    var maxLength: Int = 0
    
    public var returnValueAction: ((String) -> Void)?
    public var didChangeTextAction: ((String) -> Void)?
    
    // MARK: - UI Components
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .r14
        textField.textColor = .neutralBlack
        textField.backgroundColor = .neutralWhite
        textField.placeholder = "placeholder"
        textField.layer.cornerRadius = 10
        textField.setPlaceholder(color: .neutral500)
        textField.addLeftPadding(amount: 14)
        return textField
    }()
    
    lazy var textCountLabel: UILabel = {
        let label = UILabel()
        label.font = .r12
        label.textColor = .neutral600
        label.text = "0/\(self.maxLength)"
        return label
    }()
    
    // MARK: - Initializers
    public init(
        placeholder: String,
        maxLength: Int
    ) {
        super.init(frame: .zero)
        self.textField.placeholder = placeholder
        self.maxLength = maxLength
        self.attribute()
        self.setUI()
        self.textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - public
    public func attribute() {
        self.textField.addTarget(self, action: #selector(self.didChangeTextFieldText(_:)), for: .editingChanged)
    }
    
    public func setUI() {
        self.addSubview(textField)
        textField.snp.makeConstraints {
            $0.height.equalTo(48)
        
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(textCountLabel)
        textCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(textField.snp.trailing).offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
    
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        self.textField.becomeFirstResponder()
    }
    
    public func getTextFieldValue() -> String {
        return textField.text ?? ""
    }
    
    @objc
    private func didChangeTextFieldText(_ textField: UITextField) {
        if let text = self.textField.text {
            if text.count >= self.maxLength {
                let index = text.index(text.startIndex, offsetBy: self.maxLength)
                let newString = text[text.startIndex..<index]
                self.textField.text = String(newString)
            }
            
            self.textCountLabel.text = "\(text.count)/\(self.maxLength)"
            self.didChangeTextAction?(self.textField.text ?? "")
        }
    }
}

extension YakgwaTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.returnValueAction?(textField.text ?? "")
        return true
    }
}
