//
//  ProfileHeaderView.swift
//  ft_hangouts
//
//  Created by Zuleykha Pavlichenkova on 13.04.2024.
//  Copyright © 2024 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit

final class ProfileHeaderView: UIView {
    // MARK: - Properties
    let profileNameLabel = ProfileNameLabelView()
    private let leftSpacerView = UIView()
    private let rightSpacerView = UIView()
    
    lazy var userPicure: UIImageView = {
        let userpic = UIImageView()
        userpic.translatesAutoresizingMaskIntoConstraints = false
        userpic.contentMode = .scaleAspectFill
        userpic.layer.cornerRadius = 75
        userpic.clipsToBounds = true
        return userpic
    }()
    
    private lazy var profileImageStackView = UIStackView(arrangedSubviews: [leftSpacerView, userPicure, rightSpacerView])
    
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageStackView, profileNameLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func setUpStackView() {
        addSubview(profileStackView)
        profileStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileStackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            profileStackView.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 500),
            profileStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            profileStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            userPicure.heightAnchor.constraint(equalToConstant: 150),
            userPicure.widthAnchor.constraint(equalToConstant: 150),
            userPicure.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        userPicure.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.horizontal)
        userPicure.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.vertical)
        
        profileNameLabel.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.horizontal)
        profileNameLabel.setContentHuggingPriority(UILayoutPriority(251), for: NSLayoutConstraint.Axis.vertical)
        profileNameLabel.contentCompressionResistancePriority(for:  NSLayoutConstraint.Axis.horizontal)
    }
}
