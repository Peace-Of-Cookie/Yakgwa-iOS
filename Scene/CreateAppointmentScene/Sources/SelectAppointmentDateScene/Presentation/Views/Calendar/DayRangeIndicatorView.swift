//
//  DayRangeIndicatorView.swift
//
//
//  Created by Ekko on 7/19/24.
//

import UIKit

import DesignSystem
import HorizonCalendar

public final class DayRangeIndicatorView: UIView {
    // MARK: - Properties
    public let indicatorColor: UIColor
    public var framesOfDaysToHighlight = [CGRect]() {
        didSet {
            guard framesOfDaysToHighlight != oldValue else { return }
            setNeedsDisplay()
        }
    }
    
    // MARK: - UI Components
    
    // MARK: - Initializers
    public init(indicatorColor: UIColor) {
        self.indicatorColor = indicatorColor
        
        super.init(frame: .zero)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(indicatorColor.cgColor)
        
        if traitCollection.layoutDirection == .rightToLeft {
            context?.translateBy(x: bounds.midX, y: bounds.midY)
            context?.scaleBy(x: -1, y: 1)
            context?.translateBy(x: -bounds.midX, y: -bounds.midY)
        }
        
        // Get frames of day rows in the range
        var dayRowFrames = [CGRect]()
        var currentDayRowMinY: CGFloat?
        for dayFrame in framesOfDaysToHighlight {
            
            var adjustedDayFrame = dayFrame
            let desiredHeight = dayFrame.height * 0.6
            let verticalOffset = (dayFrame.height - desiredHeight) / 2
            adjustedDayFrame.origin.y += verticalOffset
            adjustedDayFrame.size.height = desiredHeight
            
            if adjustedDayFrame.minY != currentDayRowMinY {
                currentDayRowMinY = adjustedDayFrame.minY
                dayRowFrames.append(adjustedDayFrame)
            } else {
                let lastIndex = dayRowFrames.count - 1
                dayRowFrames[lastIndex] = dayRowFrames[lastIndex].union(adjustedDayFrame)
            }
        }
        
        // Draw rounded rectangles for each day row
        for (index, dayRowFrame) in dayRowFrames.enumerated() {
            var roundedRectanglePath: UIBezierPath
            print("\(index) 프레임: \(dayRowFrames)")
            if dayRowFrames.count == 1 {
                let cornerRadius = dayRowFrame.height / 5
                roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: cornerRadius)
            } else {
                if index == 0 {
                    let cornerRadius = dayRowFrame.height / 5
                    
                    roundedRectanglePath = UIBezierPath(
                        roundedRect: dayRowFrame,
                        byRoundingCorners: [.topLeft, .bottomLeft],
                        cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
                    )
                } else if index == dayRowFrames.count - 1 {
                    let cornerRadius = dayRowFrame.height / 5
                    roundedRectanglePath = UIBezierPath(
                        roundedRect: dayRowFrame,
                        byRoundingCorners: [.topRight, .bottomRight],
                        cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
                    )
                } else {
                    roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: 0)
                }
            }
            
            context?.addPath(roundedRectanglePath.cgPath)
            context?.fillPath()
        }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setNeedsDisplay()
    }
}

// MARK: CalendarItemViewRepresentable
extension DayRangeIndicatorView: CalendarItemViewRepresentable {
    public typealias ViewType = DayRangeIndicatorView
    public typealias ViewModel = Content
    
    public struct InvariantViewProperties: Hashable {
        
        var indicatorColor = UIColor.primary100
        
        public init(indicatorColor: UIColor = .primary100) {
            self.indicatorColor = indicatorColor
        }
    }
    
    public struct Content: Equatable {
        let framesOfDaysToHighlight: [CGRect]
        
        public init(framesOfDaysToHighlight: [CGRect]) {
            self.framesOfDaysToHighlight = framesOfDaysToHighlight
        }
    }
    
    public static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties
    ) -> DayRangeIndicatorView {
        DayRangeIndicatorView(indicatorColor: invariantViewProperties.indicatorColor)
    }
    
    public static func setViewModel(_ viewModel: Content, on view: DayRangeIndicatorView) {
        view.framesOfDaysToHighlight = viewModel.framesOfDaysToHighlight
    }
}
