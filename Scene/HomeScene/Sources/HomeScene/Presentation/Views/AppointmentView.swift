//
//  AppointmentView.swift
//
//
//  Created by Ekko on 7/11/24.
//

import UIKit

import CoreKit
import SnapKit

public enum AppointmentState {
    case waiting
    case voted
}

public class AppointmentView: UIView {

    // MARK: - Properties
    private var viewState: AppointmentState

    // MARK: - UI Components
    private lazy var tagStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()

    private lazy var tagView: TagView = {
        let view = TagView(tag: "모임 테마")
        return view
    }()

    private lazy var dDayLabel: UILabel = {
        let label = UILabel()
        label.text = "D - 6"
        label.font = .sb20
        label.textColor = .secondary700
        return label
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약과장의 약과모임"
        label.font = .sb20
        label.textColor = .neutralBlack
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 설명입니다. 모임 설명입니다"
        label.font = .m14
        label.textColor = .neutral500
        return label
    }()

    private lazy var infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "친구들의 투표를 기다리고 있어요"
        label.font = .m16
        label.textColor = .neutralBlack
        return label
    }()

    private lazy var dateStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        return stack
    }()

    private lazy var dateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clock_icon", in: .module, with: nil)
        return imageView
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024년 5월 4일"
        label.font = .r16
        return label
    }()

    private lazy var dateSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral300
        return view
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "오후 8시"
        label.font = .r16
        return label
    }()

    private lazy var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center // Ensure alignment is center
        return stack
    }()

    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location_icon", in: .module, with: nil)
        return imageView
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "닥터로빈"
        label.font = .r16
        return label
    }()
    
    private lazy var testButton: YakGwaButton = {
        let button = YakGwaButton(style: .primary)
        button.title = "모임 내용 자세히 보기"
        button.buttonImage = UIImage(named: "arrow_icon", in: .module, with: nil)
        return button
    }()

    // MARK: - Initializers
    public init(state: AppointmentState = .voted) {
        self.viewState = state
        super.init(frame: CGRect(x: 0, y: 0, width: 308, height: 256))  // 기본 사이즈 설정
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        self.backgroundColor = .neutralWhite
        
        self.snp.makeConstraints {
            $0.width.equalTo(308)
            $0.height.equalTo(256)
        }
        
        self.layer.cornerRadius = 16
        
        self.addSubview(tagStack)
        tagStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }

        tagStack.addArrangedSubview(tagView)
        tagStack.addArrangedSubview(dDayLabel)

        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(tagStack.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }

        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }

        self.addSubview(infoStack)

        if self.viewState == .waiting {
            infoStack.snp.makeConstraints {
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
                $0.centerX.equalToSuperview()
            }

            infoStack.addArrangedSubview(infoLabel)

            self.addSubview(testButton)
            testButton.snp.makeConstraints {
                $0.top.equalTo(infoStack.snp.bottom).offset(16)
                $0.bottom.equalToSuperview().offset(-16)
                $0.centerX.equalToSuperview()
            }
        } else {
            infoStack.snp.makeConstraints {
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
                $0.centerX.equalToSuperview()
            }
            infoStack.addArrangedSubview(dateStack)
            dateStack.addArrangedSubview(dateImageView)
            dateStack.addArrangedSubview(dateLabel)
            dateStack.addArrangedSubview(dateSeparator)

            dateSeparator.snp.makeConstraints {
                $0.height.equalTo(16)
                $0.width.equalTo(1)
            }

            dateStack.addArrangedSubview(timeLabel)
            infoStack.addArrangedSubview(locationStack)
            locationStack.addArrangedSubview(locationImageView)
            locationStack.addArrangedSubview(locationLabel)
            
            self.addSubview(testButton)
            testButton.snp.makeConstraints {
                $0.top.equalTo(infoStack.snp.bottom).offset(16)
                $0.bottom.equalToSuperview().offset(-16)
                $0.leading.equalToSuperview().offset(16)
                $0.centerX.equalToSuperview()
            }
        }
    }
}

#Preview {
    AppointmentView()
}
