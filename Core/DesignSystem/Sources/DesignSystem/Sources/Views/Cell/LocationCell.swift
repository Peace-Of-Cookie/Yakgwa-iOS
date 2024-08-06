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
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
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
        button.titleLabel?.font = .m11
        button.setTitleColor(.neutral600, for: .normal)
        button.setImage(UIImage(named: "forward_icon", in: .module, with: nil), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
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
    
    // MARK: - Life cycles
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        resetUI()
    }
    
    // MARK: - Privates
    private func setUI() {
        self.backgroundColor = .neutral200
        self.layer.cornerRadius = 15
        
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        containerView.addSubview(contentStack)
        contentStack.addArrangedSubview(titleStack)
        contentStack.addArrangedSubview(addressLabel)
        contentStack.addArrangedSubview(mapButton)
        
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        titleStack.addArrangedSubview(bookmarkImageView)
        titleStack.addArrangedSubview(titleLabel)
        bookmarkImageView.snp.makeConstraints {
            $0.width.equalTo(10)
            $0.height.equalTo(16)
        }
    }
    
    private func resetUI() {
        titleLabel.text = nil
        addressLabel.text = nil
        addressLabel.isHidden = false
        bookmarkImageView.isHidden = true
        containerView.layer.borderWidth = 0
        containerView.layer.borderColor = UIColor.clear.cgColor
    }
    
    // MARK: - Public
    public func configure(
        title: String,
        address: String,
        isBookmarked: Bool,
        isSelected: Bool
    ) {
        titleLabel.text = title
        
        if address.isEmpty {
            addressLabel.isHidden = true
        } else {
            addressLabel.isHidden = false
            addressLabel.text = address
        }
        
        bookmarkImageView.isHidden = !isBookmarked
        
        if isSelected {
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor.primary800.cgColor
        } else {
            containerView.layer.borderWidth = 0
            containerView.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
