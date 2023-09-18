//
//  HomepageTableViewCell.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/8/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit

final class HomepageTableViewCell: UITableViewCell {
    
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
        contentView.addSubview(fullNameLabel)
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            fullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            fullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
        contentView.addSubview(phoneNumberLabel)
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            phoneNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

        ])
        
    }

    func configure(with contact: Contact) {
        fullNameLabel.text = contact.firstName + " " + contact.lastName
//        phoneNumberLabel.text = contact.phoneNumber
//        accessoryType = .detailButton
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fullNameLabel.text = ""
        phoneNumberLabel.text = ""
    }
    
    
}
