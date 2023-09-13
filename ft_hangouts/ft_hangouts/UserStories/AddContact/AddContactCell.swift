//
//  AddContactCell.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/13/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit

final class AddContactCell: UITableViewCell {
    
        private lazy var nameLabel: UITextField = {
            let field = UITextField()
            field.translatesAutoresizingMaskIntoConstraints = false
            field.font = .systemFont(ofSize: 20, weight: .bold)
            
            field.text = "Name"
            return field
        }()
        
        private lazy var lastNameLabel: UITextField = {
            let field = UITextField()
            field.translatesAutoresizingMaskIntoConstraints = false
            field.font = .systemFont(ofSize: 20, weight: .bold)
            
            field.text = "Lastname"
            return field
        }()
        
        private lazy var birthDateLabel: UITextField = {
            let field = UITextField()
            field.translatesAutoresizingMaskIntoConstraints = false
            field.font = .systemFont(ofSize: 14, weight: .regular)
            
            field.text = "10.10.2010"
            return field
        }()
        
        private lazy var phoneNumberLabel: UITextField = {
            let field = UITextField()
            field.translatesAutoresizingMaskIntoConstraints = false
            field.font = .systemFont(ofSize: 14, weight: .regular)
            
            field.text = "+31 3131 313131"
            return field
        }()
        
        private lazy var emailLabel: UITextField = {
            let field = UITextField()
            field.translatesAutoresizingMaskIntoConstraints = false
            field.font = .systemFont(ofSize: 14, weight: .regular)
            
            field.text = "31@31.nl"
            return field
        }()
        
        private lazy var verticalStack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.alignment = .center
            stack.axis = .vertical
            stack.distribution = .equalSpacing
    //        stack.spacing = 8
            return stack
        }()
        
        
        func setUpUI() {
            
            contentView.addSubview(verticalStack)
            NSLayoutConstraint.activate([
                verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
                verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
            
            verticalStack.addArrangedSubview(nameLabel)
            verticalStack.addArrangedSubview(lastNameLabel)
            verticalStack.addArrangedSubview(birthDateLabel)
            verticalStack.addArrangedSubview(phoneNumberLabel)
            verticalStack.addArrangedSubview(emailLabel)
        }
    
    
}

