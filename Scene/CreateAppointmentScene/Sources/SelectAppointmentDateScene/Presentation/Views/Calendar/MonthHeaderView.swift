//
//  MonthHeaderView.swift
//
//
//  Created by Ekko on 7/19/24.
//

import UIKit

import HorizonCalendar
import DesignSystem

public final class MonthHeaderView: UIView {
    // MARK: - Properties
    private let invariantViewProperties: InvariantViewProperties
    
    // MARK: - UI Components
    private let label: UILabel
    
    // MARK: - Initializers
    public init(invariantViewProperties: InvariantViewProperties) {
        self.invariantViewProperties = invariantViewProperties
        
        self.label = UILabel()
        label.font = invariantViewProperties.font
        label.textAlignment = invariantViewProperties.textAlignment
        label.textColor = invariantViewProperties.textColor
        
        super.init(frame: .zero)
        
        backgroundColor = invariantViewProperties.backgroundColor
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
    
    fileprivate func setViewModel(_ viewModel: ViewModel) {
        label.text = viewModel.monthText
        accessibilityLabel = viewModel.accessibilityLabel
    }
}

// MARK: Accessibility
extension MonthHeaderView {
    
    public override var isAccessibilityElement: Bool {
        get { true }
        set { }
    }
    
    public override var accessibilityTraits: UIAccessibilityTraits {
        get { invariantViewProperties.accessibilityTraits }
        set { }
    }
}

// MARK: - DayView.ViewModel
extension MonthHeaderView {
    
    /// Encapsulates the data used to populate a `AddTermMonthHeaderView`'s text label. Use a `DateFormatter` to create the
    /// `monthText` and `accessibilityLabel` strings.
    ///
    /// - Note: To avoid performance issues, reuse the same `DateFormatter` for each month, rather than creating
    /// a new `DateFormatter` for each month.
    public struct ViewModel: Equatable {
        
        // MARK: Properties
        public let monthText: String
        public let accessibilityLabel: String?
        
        // MARK: Init
        public init(monthText: String, accessibilityLabel: String?) {
            self.monthText = monthText
            self.accessibilityLabel = accessibilityLabel
        }
    }
}

extension MonthHeaderView {
    public struct InvariantViewProperties: Hashable {
        public static let base = InvariantViewProperties()
        
        public var backgroundColor = UIColor.clear
        
        public var edgeInsets = NSDirectionalEdgeInsets.zero
        
        public var font = UIFont.sb16
        
        public var textAlignment = NSTextAlignment.natural
        
        public var textColor: UIColor = .neutralBlack
        
        public var accessibilityTraits = UIAccessibilityTraits.header
        
        private init() { }
    }
}

extension MonthHeaderView: CalendarItemViewRepresentable {
    public static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties
    ) -> MonthHeaderView {
        MonthHeaderView(invariantViewProperties: invariantViewProperties)
    }
    
    public static func setViewModel(_ viewModel: ViewModel, on view: MonthHeaderView) {
        view.setViewModel(viewModel)
    }
}
