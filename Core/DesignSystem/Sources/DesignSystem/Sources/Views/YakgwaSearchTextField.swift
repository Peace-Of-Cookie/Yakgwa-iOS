//
//  YakgwaSearchTextField.swift
//
//
//  Created by Ekko on 7/19/24.
//

import UIKit

import Util
import RxSwift
import RxCocoa

public final class YakgwaSearchTextField: UIView {
    // MARK: - Properties
    public var returnValueAction: ((String) -> Void)?
    public var didChangeTextAction: ((String) -> Void)?
    
    public var imageString: String = ""
    
    // MARK: - UI Components
    fileprivate lazy var textField: UITextField = {
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
    
    private lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // MARK: - Initializers
    public init(
        placeholder: String,
        image: String = "search_icon"
    ) {
        self.imageString = image
        
        super.init(frame: .zero)
        
        self.textField.placeholder = placeholder
        
        attribute()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() {
        self.textField.addTarget(self, action: #selector(self.didChangeTextFieldText(_:)), for: .editingChanged)
        self.button.setImage(UIImage(named: imageString, in: .module, with: nil), for: .normal)
    }
    
    private func setUI() {
        self.addSubview(textField)
        textField.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
    }
    
    @objc
    private func didChangeTextFieldText(_ textField: UITextField) {
        self.didChangeTextAction?(self.textField.text ?? "")
    }
    
    // MARK: - Publics
    public func getTextFieldValue() -> String {
        return textField.text ?? ""
    }
}

extension YakgwaSearchTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.returnValueAction?(textField.text ?? "")
        return true
    }
}

public extension Reactive where Base: YakgwaSearchTextField {
  var text: ControlProperty<String?> {
    return base.textField.rx.text
  }
}
