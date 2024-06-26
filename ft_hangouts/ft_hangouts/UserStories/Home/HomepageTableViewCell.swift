//
//  HomepageTableViewCell.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/8/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit
import CoreData

final class HomepageTableViewCell: UITableViewCell {
        
    private lazy var userPicure: UIImageView = {
        let userpic = UIImageView()
        userpic.translatesAutoresizingMaskIntoConstraints = false
        userpic.contentMode = .scaleAspectFill
        userpic.layer.cornerRadius = 25
        userpic.clipsToBounds = true
        return userpic
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        let dynamicColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return .systemMint
            } else {
                return .label
            }
        }
        label.textColor = dynamicColor
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        
        let dynamicColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return .label
            } else {
                return .systemPurple
            }
        }
        label.textColor = dynamicColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.addSubview(userPicure)
        NSLayoutConstraint.activate([
            userPicure.widthAnchor.constraint(equalToConstant: 50),
            userPicure.heightAnchor.constraint(equalToConstant: 50),
            userPicure.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userPicure.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
        contentView.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            verticalStack.leadingAnchor.constraint(equalTo: userPicure.trailingAnchor, constant: 24),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        verticalStack.addArrangedSubview(fullNameLabel)
        verticalStack.addArrangedSubview(phoneNumberLabel)
    }

    func configure(with contact: DBContact) {
        guard
            case let name = contact.firstName,
            let lastName = contact.lastName
        else { return }
        if let imageData = contact.userPicture {
            userPicure.image = UIImage(data: imageData)
        }
        fullNameLabel.text = name + " " + lastName
        phoneNumberLabel.text = contact.phoneNumber
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fullNameLabel.text = ""
        phoneNumberLabel.text = ""
    }
}
