//
//  LocationCell.swift
//
//
//  Created by Kim Dongjoo on 8/6/24.
//

import UIKit
import Domain

final public class LocationCell: UITableViewCell {
    // MARK: - Properties
    public static let identifier = "LocationCell"
    
    // MARK: - UI Components
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "장소명"
        label.font = .m14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bookmark_icon", in: .module, with: nil)
        return imageView
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "주소"
        label.font = .m11
        label.textColor = .neutral700
        return label
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton()
        button.setTitle("지도 바로가기", for: .normal)
        button.setTitleColor(.neutral600, for: .normal)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "forward_icon", in: .module, with: nil)
        config.imagePlacement = .trailing
        config.imagePadding = 8
        button.configuration = config
        return button
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .neutral200
        self.layer.cornerRadius = 15
        
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        containerView.addSubview(titleStack)
        titleStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        titleStack.addArrangedSubview(bookmarkImageView)
        titleStack.addArrangedSubview(titleLabel)
        bookmarkImageView.snp.makeConstraints {
            $0.width.equalTo(10)
            $0.height.equalTo(16)
        }
        
        containerView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        containerView.addSubview(mapButton)
        mapButton.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Public
    public func configure(title: String, address: String, isBookmarked: Bool) {
        titleLabel.text = title
        addressLabel.text = address
        bookmarkImageView.isHidden = !isBookmarked
    }
}
