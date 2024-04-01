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
        userpic.layer.cornerRadius = 17
        userpic.clipsToBounds = true
        userpic.tintColor = .gray
        userpic.image = UIImage(systemName: "person.crop.circle.fill")
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
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
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
        contentView.addSubview(userPicure)
        NSLayoutConstraint.activate([
            userPicure.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userPicure.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userPicure.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            userPicure.widthAnchor.constraint(equalToConstant: 51),
            userPicure.heightAnchor.constraint(equalToConstant: 51)
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
        
        fullNameLabel.text = name + " " + lastName
        phoneNumberLabel.text = contact.phoneNumber
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fullNameLabel.text = ""
        phoneNumberLabel.text = ""
    }
}
