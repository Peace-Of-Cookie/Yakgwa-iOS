//
//  SelectAppointmentDateViewController.swift
//
//
//  Created by Ekko on 7/19/24.
//

import UIKit

import CoreKit
import ReactorKit
import HorizonCalendar
import RxCocoa

public final class SelectAppointmentDateViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    private var selectedDayRange: DayRange?
    private let selectedDayRangeObserver = PublishRelay<DayRange?>()
    private let modeObserver = BehaviorRelay<YakgwaSwitchViewState>(value: .first)
    
    // Calendar properties
    private lazy var calendar: Calendar = {
        var calendar = Calendar.current
        return calendar
    }()
    let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    let endDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    
    // MARK: - UI Components
    private lazy var navigationBar: YakgwaNavigationDetailBar = {
        let nav = YakgwaNavigationDetailBar()
        nav.delegate = self
        nav.configure(previousTitle: "약속 만들기")
        return nav
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투표에 올릴 기간을 선택해주세요"
        label.font = .m14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 2주까지 설정 가능"
        label.font = .m11
        label.textColor = .neutral600
        return label
    }()
    
    private lazy var yakgwaSwitchView: YakgwaSwitchView = {
        let view = YakgwaSwitchView()
        view.delegate = self
        return view
    }()
    
    private lazy var bottomSheetButton: BottomSheetButton = {
        let button = BottomSheetButton(title: "다음으로")
        return button
    }()
    
    private lazy var calendarView: CalendarView = {
        let calendarView = CalendarView(initialContent: self.makeContent())
        return calendarView
    }()
    
    private lazy var dateSearchTextField: YakgwaSearchTextField = {
        let textField = YakgwaSearchTextField(placeholder: "날짜를 입력해주세요")
        return textField
    }()
    
    private lazy var timeSearchTextField: YakgwaSearchTextField = {
        let textField = YakgwaSearchTextField(placeholder: "시간를 입력해주세요")
        return textField
    }()
    
    // MARK: - Initializers
    public init(
        reactor: SelectAppointmentDateReactor
    ) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setCalendarSelection()
    }
    
    // MARK: - Privates
    private func setUI() {
        self.view.backgroundColor = .neutral200
        
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.view.addSubview(bottomSheetButton)
        bottomSheetButton.snp.makeConstraints {
            $0.height.equalTo(92)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        self.view.addSubview(yakgwaSwitchView)
        yakgwaSwitchView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(titleStack)
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(descriptionLabel)
        
        titleStack.snp.makeConstraints {
            $0.top.equalTo(yakgwaSwitchView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.view.addSubview(calendarView)
        calendarView.snp.makeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    public func bind(reactor: SelectAppointmentDateReactor) {
        // Action
        selectedDayRangeObserver
            .map { dayRange -> SelectAppointmentDateReactor.Action in
                guard let dayRange else { return .selectDateRange(nil) }
                let calendar = Calendar.current
                guard
                    let lowerBound = calendar.date(from: dayRange.lowerBound.components),
                    let upperBound = calendar.date(from: dayRange.upperBound.components)
                else { return .selectDateRange(nil) }
                
                return .selectDateRange([lowerBound...upperBound])
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        modeObserver
            .map { Reactor.Action.changeMode($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func changeMode(state: YakgwaSwitchViewState) {
        if state == .first {
            titleLabel.text = "투표에 올릴 기간을 선택해주세요"
            titleStack.addArrangedSubview(descriptionLabel)
            descriptionLabel.isHidden = false
            calendarView.isHidden = false
            
            dateSearchTextField.removeFromSuperview()
            timeSearchTextField.removeFromSuperview()
        } else {
            titleLabel.text = "정해진 양속 장소를 입력해주세요"
            descriptionLabel.isHidden = true
            calendarView.isHidden = true
            titleStack.removeArrangedSubview(descriptionLabel)
            self.view.addSubview(dateSearchTextField)
            dateSearchTextField.snp.makeConstraints {
                $0.top.equalTo(titleStack.snp.bottom).offset(8)
                $0.leading.equalToSuperview().offset(16)
                $0.centerX.equalToSuperview()
            }
            
            self.view.addSubview(timeSearchTextField)
            timeSearchTextField.snp.makeConstraints {
                $0.top.equalTo(dateSearchTextField.snp.bottom).offset(8)
                $0.leading.equalToSuperview().offset(16)
                $0.centerX.equalToSuperview()
            }
        }
    }
    
    private func setInputUI() {
        titleLabel.text = "정해진 약속 시간을 입력해주세요"
        titleStack.removeArrangedSubview(descriptionLabel)
        
        
    }
    
    private func makeContent() -> CalendarViewContent {
        let dateRanges: Set<ClosedRange<Date>>
        let selectedDayRange = selectedDayRange
        
        let calendar = self.calendar
        
        if let selectedDayRange,
           let lowerBound = calendar.date(from: selectedDayRange.lowerBound.components),
           let upperBound = calendar.date(from: selectedDayRange.upperBound.components) {
            dateRanges = [lowerBound...upperBound]
        } else {
            dateRanges = []
        }
    
        
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .horizontal(options: HorizontalMonthsLayoutOptions())
        )
        .monthDayInsets(.init(top: 0, left: 0, bottom: 0, right: 16))
        .daysOfTheWeekRowSeparator(options: .init(height: 2, color: .neutral200))
        // Header
        .monthHeaderItemProvider { month in
            let invariantViewProperties = MonthHeaderView.InvariantViewProperties.base
            
            let monthText = month.month < 10 ? "\(month.year).0\(month.month)" : "\(month.year).\(month.month)"
            
            return MonthHeaderView.calendarItemModel(
                invariantViewProperties: invariantViewProperties,
                viewModel: .init(
                    monthText: monthText,
                    accessibilityLabel: monthText
                )
            )
        }
        // Day
        .dayItemProvider { day in
            var invariantViewProperties = DayView.InvariantViewProperties.baseInteractive
            invariantViewProperties.font = .m14
            
            let isSelectedStyle: Bool
            
            if let selectedDayRange {
                isSelectedStyle = day == selectedDayRange.lowerBound || day == selectedDayRange.upperBound
            } else {
                isSelectedStyle = false
            }
            
            if self.startDate > self.calendar.date(from: DateComponents(year: day.month.year, month: day.month.month, day: day.day))! ||
                self.endDate < self.calendar.date(from: DateComponents(year: day.month.year, month: day.month.month, day: day.day))! {
                invariantViewProperties.textColor = .neutral500
            }
            
            let passMarkType: DayView.PassMarkType
            if self.calendar.date(from: DateComponents(year: day.month.year, month: day.month.month, day: day.day))! == self.startDate {
                passMarkType = .start
                invariantViewProperties.textColor = .neutral200
            } else if self.calendar.date(from: DateComponents(year: day.month.year, month: day.month.month, day: day.day))! == self.endDate {
                passMarkType = .end
                invariantViewProperties.textColor = .systemGreen
            } else {
                passMarkType = .none
            }
            
            if isSelectedStyle {
                // 선택
                invariantViewProperties.backgroundShapeDrawingConfig.fillColor = .clear
                invariantViewProperties.backgroundShapeDrawingConfig.borderColor = .clear
                invariantViewProperties.textColor = .neutralWhite
            }
            
            let dayText = "\(day.day)"
            return DayView.calendarItemModel(
                invariantViewProperties: invariantViewProperties,
                viewModel: .init(
                    dayText: dayText,
                    accessibilityLabel: dayText,
                    accessibilityHint: nil,
                    passMarkType: passMarkType,
                    isSelected: isSelectedStyle
                )
            )
        }
        // Day Range
        .dayRangeItemProvider(for: dateRanges) { dayRangeLayoutContext in
            DayRangeIndicatorView.calendarItemModel(
              invariantViewProperties: .init(),
              viewModel: .init(
                framesOfDaysToHighlight: dayRangeLayoutContext.daysAndFrames.map { $0.frame })
            )
        }
    }
    
    private func setCalendarSelection() {
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self else { return }
            
            if self.startDate > self.calendar.date(from: DateComponents(year: day.month.year, month: day.month.month, day: day.day))! ||
                self.endDate < self.calendar.date(from: DateComponents(year: day.month.year, month: day.month.month, day: day.day))! {
                return
            }
            
            DayRangeSelectionHelper.updateDayRange(
                afterTapSelectionOf: day,
                existingDayRange: &self.selectedDayRange
            )
            
            self.selectedDayRangeObserver.accept(self.selectedDayRange)
            
            self.calendarView.setContent(self.makeContent())
        }
    }
}

extension SelectAppointmentDateViewController: YakgwaNavigationDetailDelegate {
    public func didTapDetailLeftButton() {
        print("didTapDetailLeftButton")
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelectAppointmentDateViewController: YakgwaSwitchViewDelegate {
    public func yakgwaSwitchView(state: YakgwaSwitchViewState) {
        print("yakgwaSwitchMode: \(state)")
        self.changeMode(state: state)
        self.modeObserver.accept(state)
    }
}
