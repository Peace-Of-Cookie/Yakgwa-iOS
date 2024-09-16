//
//  AddLocationCandidateCell.swift
//
//
//  Created by Kim Dongjoo on 9/10/24.
//

import UIKit

import CoreKit

final class AddLocationCandidateCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "AddLocationCandidateCell"
    
    // MARK: - UI Components
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var addButton: YakGwaButton = {
        let button = YakGwaButton(style: .white, image: .plus)
        button.title = "후보지 추가하기"
        return button
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Privates
    private func attribute() {
        self.selectionStyle = .none
    }
    
    private func setUI() {
        self.backgroundColor = .neutral200
        self.layer.cornerRadius = 15
        
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        containerView.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.edges.equalToSuperview()
        }
    }
}
