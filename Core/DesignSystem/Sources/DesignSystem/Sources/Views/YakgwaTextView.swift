//
//  YakgwaTextView.swift
//
//
//  Created by Ekko on 7/18/24.
//

import UIKit

import Util
import RxSwift
import RxCocoa

public protocol YakgwaTextViewDelegate: AnyObject {
    func textViewDidEndEditing(text: String)
    func textViewDidChange(text: String)
}

public final class YakgwaTextView: UIView {
    // MARK: - Properties
    public weak var customDelegate: YakgwaTextViewDelegate?
    
    var maxLength: Int = 0
    var placeHolderText: String = ""
    
    // MARK: - UI Components
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.backgroundColor = .neutralWhite
        textView.font = .r14
        textView.textColor = .neutralBlack
        textView.isEditable = true
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .r14
        label.textColor = .neutral500
        return label
    }()
    
    private lazy var textCountLabel: UILabel = {
        let label = UILabel()
        label.font = .r12
        label.textColor = .neutral600
        return label
    }()

    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.attribute()
    }
    
    public convenience init(
        placeHolderText: String,
        maxLength: Int
    ) {
        self.init(frame: .zero)
        self.placeHolderText = placeHolderText
        self.maxLength = maxLength
        self.placeholderLabel.text = placeHolderText
        self.setUI()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func attribute() {
        self.textView.contentInset = .init(top: 8, left: 10, bottom: 8, right: 10)
        self.layer.cornerRadius = 10
        textCountLabel.text = "0/\(self.maxLength)"
    }
    
    private func setUI() {
        self.addSubview(textView)
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(textCountLabel)
        textCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}

extension YakgwaTextView: UITextViewDelegate {
    public func textViewDidEndEditing(_ textView: UITextView) {
        self.customDelegate?.textViewDidEndEditing(text: textView.text)
        self.placeholderLabel.isHidden = !self.textView.text.isEmpty
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if textView.text != nil && !textView.text.isEmpty {
            self.placeholderLabel.text = ""
            textView.textColor = .neutralBlack
        } else {
            self.placeholderLabel.text = self.placeHolderText
        }
        
        if self.textView.text.count > self.maxLength {
            self.textView.text.removeLast()
        }
        
        self.textCountLabel.text = "\(textView.text.count)/\(self.maxLength)"
        self.customDelegate?.textViewDidChange(text: textView.text)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText replacement: String) -> Bool {
        let newLength = self.textView.text.count - range.length + replacement.count
        let maxCount = self.maxLength
         
        if newLength > maxCount {
            let overflow = newLength - maxCount
            if replacement.count < overflow {
                return true
            }
            let index = replacement.index(replacement.endIndex, offsetBy: -overflow)
            let newText = replacement[..<index]
            guard let startPosition = textView.position(from: textView.beginningOfDocument, offset: range.location) else { return false }
            guard let endPosition = textView.position(from: textView.beginningOfDocument, offset: NSMaxRange(range)) else { return false }
            guard let textRange = textView.textRange(from: startPosition, to: endPosition) else { return false }

            textView.replace(textRange, withText: String(newText))

            return false
        }
        return true
    }
}

// Reactive Extension
public extension Reactive where Base: YakgwaTextView {
    var text: ControlProperty<String?> {
        let source: Observable<String?> = Observable.deferred { [weak base] in
            guard let textView = base?.textView else {
                return Observable.empty()
            }
            return textView.rx.text.asObservable()
        }
        
        let bindingObserver = Binder(base) { (view, text: String?) in
            view.textView.text = text
            view.textView.delegate?.textViewDidChange?(view.textView)
        }
        
        return ControlProperty(values: source, valueSink: bindingObserver)
    }
}
