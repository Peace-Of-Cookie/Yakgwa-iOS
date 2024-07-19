//
//  DayView.swift
//
//
//  Created by Ekko on 7/19/24.
//

import UIKit

import DesignSystem
import HorizonCalendar

public final class DayView: UIView {
    // MARK: - Properties
    private let invariantViewProperties: InvariantViewProperties
    private let backgroundImage: UIImage? = UIImage(named: "calendar_picker", in: .module, with: nil)
    private let backgroundLayer: CAShapeLayer
    private let highlightLayer: CAShapeLayer?
    private let dayLabel: UILabel
    
    private var feedbackGenerator: UISelectionFeedbackGenerator? // 멍미?
    
    // MARK: - UI Components
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = backgroundImage
        imageView.isHidden = false
        return imageView
    }()
    
    // MARK: - Initializers
    init(invariantViewProperties: InvariantViewProperties) {
        self.invariantViewProperties = invariantViewProperties
        
        let backgroundShapeDrawingConfig = invariantViewProperties.backgroundShapeDrawingConfig
        backgroundLayer = CAShapeLayer()
        
        backgroundLayer.fillColor = backgroundShapeDrawingConfig.fillColor.cgColor
        backgroundLayer.strokeColor = backgroundShapeDrawingConfig.borderColor.cgColor
        backgroundLayer.lineWidth = backgroundShapeDrawingConfig.borderWidth
        
        dayLabel = UILabel()
        dayLabel.font = invariantViewProperties.font
        dayLabel.textAlignment = invariantViewProperties.textAlignment
        dayLabel.textColor = invariantViewProperties.textColor
        
        let isUserInteractionEnabled: Bool
        let supportsPointerInteraction: Bool
        
        switch invariantViewProperties.interaction {
        case .disabled:
            isUserInteractionEnabled = false
            supportsPointerInteraction = false
            highlightLayer = nil
            
        case let .enabled(_, supportsPointerInteractionItem):
            isUserInteractionEnabled = true
            supportsPointerInteraction = supportsPointerInteractionItem
            
            let highlightShapeDrawingConfig = invariantViewProperties.highlightShapeDrawingConfig
            highlightLayer = CAShapeLayer()
            
            highlightLayer?.fillColor = highlightShapeDrawingConfig.fillColor.cgColor
            highlightLayer?.strokeColor = highlightShapeDrawingConfig.borderColor.cgColor
            highlightLayer?.lineWidth = highlightShapeDrawingConfig.borderWidth
        }
        
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.backgroundColor = invariantViewProperties.backgroundColor
        
        self.layer.addSublayer(backgroundLayer)
        
        highlightLayer.map { layer.addSublayer($0) }
        setHighlightLayerVisibility(isHidden: true, animated: false)
        
        if supportsPointerInteraction {
            addInteraction(UIPointerInteraction(delegate: self))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycles
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        setUI()
    }
    
    // MARK: - Public
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        setHighlightLayerVisibility(isHidden: false, animated: true)
        
        if case let .enabled(playsHapticsOnTouchDown, _) = invariantViewProperties.interaction, playsHapticsOnTouchDown {
            feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator?.prepare()
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        setHighlightLayerVisibility(isHidden: true, animated: true)
        
        feedbackGenerator?.selectionChanged()
        feedbackGenerator = nil
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        setHighlightLayerVisibility(isHidden: true, animated: true)
        feedbackGenerator = nil
    }
    
    // MARK: - Privates
    private func setUI() {
        let edgeInsets = invariantViewProperties.edgeInsets
        let insetBounds = bounds.inset(
            by: UIEdgeInsets(
                top: edgeInsets.top,
                left: edgeInsets.leading,
                bottom: edgeInsets.bottom,
                right: edgeInsets.trailing
            )
        )
        
        let path: CGPath
        switch invariantViewProperties.shape {
        default:
            let radius = min(insetBounds.size.width, insetBounds.size.height) / 2
            let origin = CGPoint(x: insetBounds.midX - radius, y: insetBounds.midY - radius)
            let size = CGSize(width: radius * 2, height: radius * 2)
            path = UIBezierPath(ovalIn: CGRect(origin: origin, size: size)).cgPath
        }
        
        backgroundLayer.path = path
        highlightLayer?.path = path
        
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.center.equalToSuperview()
            // $0.edges.equalToSuperview()
        }
        
        self.addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        
    }
    
    fileprivate func setViewModel(_ viewModel: ViewModel) {
        dayLabel.text = viewModel.dayText
        
        accessibilityLabel = viewModel.accessibilityLabel
        accessibilityHint = viewModel.accessibilityHint
        
        switch viewModel.isSelected {
        case true:
            backgroundImageView.isHidden = false
        case false:
            backgroundImageView.isHidden = true
        }
    }
    
    private func setHighlightLayerVisibility(isHidden: Bool, animated: Bool) {
        guard let highlightLayer = highlightLayer else { return }
        
        let opacity: Float = isHidden ? 0 : 1
        
        if animated {
            let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
            animation.fromValue = highlightLayer.presentation()?.opacity ?? highlightLayer.opacity
            animation.toValue = opacity
            animation.duration = 0.06
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            highlightLayer.add(animation, forKey: "fade")
        }
        
        highlightLayer.opacity = opacity
    }
}
// MARK: Accessibility
extension DayView {
    
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
extension DayView {
    
    // MARK: - Enum
    public enum PassMarkType {
        case start
        case end
        case none
    }
    
    /// Encapsulates the data used to populate a `CustomDayView`'s text label. Use a `DateFormatter` to create the
    /// `accessibilityLabel` string.
    ///
    /// - Note: To avoid performance issues, reuse the same `DateFormatter` for each day, rather than creating
    /// a new `DateFormatter` for each day.
    public struct ViewModel: Equatable {
        
        // MARK: Properties
        public let dayText: String
        public let accessibilityLabel: String?
        public let accessibilityHint: String?
        public let passMarkType: PassMarkType
        public let isSelected: Bool
        
        // MARK: Init
        public init(
            dayText: String,
            accessibilityLabel: String?,
            accessibilityHint: String?,
            passMarkType: PassMarkType,
            isSelected: Bool
        ) {
            self.dayText = dayText
            self.accessibilityLabel = accessibilityLabel
            self.accessibilityHint = accessibilityHint
            self.passMarkType = passMarkType
            self.isSelected = isSelected
        }
    }
}

extension DayView {
    
    // MARK: - Enum
    public enum Interaction: Hashable {
        case disabled
        case enabled(playsHapticsOnTouchDown: Bool = true, supportsPointerInteraction: Bool = true)
    }
    
    /// Encapsulates configurable properties that change the appearance and behavior of `CustomDayView`. These cannot be changed after a
    /// `CustomDayView` is initialized.
    public struct InvariantViewProperties: Hashable {
        
        // MARK: Properties
        public static let baseNonInteractive = InvariantViewProperties()
        public static let baseInteractive: InvariantViewProperties = {
            var properties = baseNonInteractive
            properties.interaction = .enabled()
            properties.accessibilityTraits = .button
            return properties
        }()
        
        /// Whether user interaction is enabled or disabled. If this is set to disabled, the highlight layer will not appear on touch down and
        /// and `isUserInteractionEnabled` will be set to `false`.
        public var interaction = Interaction.disabled
        
        /// The background color of the entire view, unaffected by `edgeInsets` and behind the background and highlight layers.
        public var backgroundColor = UIColor.clear
        
        /// Edge insets that apply to the background layer, highlight layer, and text label.
        public var edgeInsets = NSDirectionalEdgeInsets.zero
        
        /// The shape of the the background and highlight layers.
        public var shape = Shape.circle
        
        /// The drawing config for the always-visible background layer.
        public var backgroundShapeDrawingConfig = DrawingConfig.transparent
        
        /// The drawing config for the highlight layer that shows up on touch-down if `self.interaction` is `.enabled`.
        public var highlightShapeDrawingConfig: DrawingConfig = {
            let color: UIColor
            if #available(iOS 13.0, *) {
                color = .systemFill
            } else {
                color = .lightGray
            }
            
            return DrawingConfig(fillColor: color, borderColor: .clear)
        }()
        
        /// The font of the day's label.
        public var font: UIFont = .m14
        
        /// The text alignment of the day's label.
        public var textAlignment = NSTextAlignment.center
        
        /// The text color of the day's label.
        public var textColor: UIColor = .neutralBlack
        
        /// The accessibility traits of the `CustomDayView`.
        public var accessibilityTraits = UIAccessibilityTraits.staticText
        
        // MARK: Init
        private init() { }
    }
}

extension DayView: CalendarItemViewRepresentable {
    
    public static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> DayView {
        DayView(invariantViewProperties: invariantViewProperties)
    }
    
    public static func setViewModel(_ viewModel: ViewModel, on view: DayView) {
        view.setViewModel(viewModel)
    }
}

extension DayView: UIPointerInteractionDelegate {
    
    public func pointerInteraction(_ interaction: UIPointerInteraction, styleFor region: UIPointerRegion) -> UIPointerStyle? {
        guard let interactionView = interaction.view else { return nil }
        
        let previewParameters = UIPreviewParameters()
        previewParameters.visiblePath = backgroundLayer.path.map { UIBezierPath(cgPath: $0) }
        
        let targetedPreview = UITargetedPreview(view: interactionView, parameters: previewParameters)
        
        return UIPointerStyle(effect: .highlight(targetedPreview))
    }
}
