//
//  AddContactViewController.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/11/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    private lazy var userPicure: UIImageView = {
        let userpic = UIImageView()
        userpic.translatesAutoresizingMaskIntoConstraints = false
        userpic.contentMode = .scaleAspectFill
        userpic.layer.cornerRadius = 60
        userpic.clipsToBounds = true
        userpic.tintColor = .gray
        return userpic
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        
        label.text = "Name"
        return label
    }()
    
    private lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        
        label.text = "Lastname"
        return label
    }()
    
    private lazy var birthDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        
        label.text = "10.10.2010"
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        
        label.text = "+31 3131 313131"
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        
        label.text = "31@31.nl"
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        
        view.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        verticalStack.addSubview(userPicure)
        verticalStack.addSubview(nameLabel)
        verticalStack.addSubview(lastNameLabel)
        verticalStack.addSubview(birthDateLabel)
        verticalStack.addSubview(phoneNumberLabel)
        verticalStack.addSubview(emailLabel)
    }
    
    @objc func saveTapped() {
        
    }
}

