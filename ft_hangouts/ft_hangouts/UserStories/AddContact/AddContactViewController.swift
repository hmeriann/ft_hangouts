//
//  AddContactViewController.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/11/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    let contacts = Contact.defaultContacts()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        return view
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .quaternarySystemFill
        return view
    }()
    
    private lazy var userPicure: UIImageView = {
        let userpic = UIImageView()
        userpic.translatesAutoresizingMaskIntoConstraints = false
        userpic.contentMode = .scaleAspectFill
        userpic.layer.cornerRadius = 60
        userpic.clipsToBounds = true
        userpic.tintColor = .gray
        userpic.image = UIImage(systemName: "person.crop.circle.fill")
        return userpic
    }()
    
    private lazy var nameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 24)
        field.borderStyle = .roundedRect
        field.placeholder = "First name"
        field.clearButtonMode = .whileEditing
        return field
    }()
    
    private lazy var lastNameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 24)
        field.borderStyle = .roundedRect
        field.placeholder = "Last name"
        field.clearButtonMode = .whileEditing

        return field
    }()
    
    private lazy var phoneNumberField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 24)
        field.borderStyle = .roundedRect
        field.placeholder = "Phone number"
        field.clearButtonMode = .whileEditing

        return field
    }()
    
    private lazy var emailField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 24)
        field.borderStyle = .roundedRect
        field.placeholder = "Email"
        field.clearButtonMode = .whileEditing

        return field
    }()
    
    private lazy var birthDateField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 24)
        field.borderStyle = .roundedRect
        field.placeholder = "Birth date"
        field.clearButtonMode = .whileEditing

        return field
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save New Contact", for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
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
    
    
    func setUpUI() {
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        scrollView.addSubview(scrollContentView)
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            // TODO: - The height is redundant when it's vertical orientation
            scrollContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 2)
            
        ])
        scrollContentView.addSubview(userPicure)
        NSLayoutConstraint.activate([
            userPicure.heightAnchor.constraint(equalToConstant: 150),
            userPicure.widthAnchor.constraint(equalToConstant: 150),
            userPicure.topAnchor.constraint(equalTo: scrollContentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            userPicure.centerXAnchor.constraint(equalTo: scrollContentView.safeAreaLayoutGuide.centerXAnchor),
        ])
        
        scrollContentView.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: userPicure.bottomAnchor, constant: 16),
            verticalStack.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant:  16),
            verticalStack.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -16),
            //            verticalStack.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
        ])
        verticalStack.addArrangedSubview(nameField)
        verticalStack.addArrangedSubview(lastNameField)
        verticalStack.addArrangedSubview(phoneNumberField)
        verticalStack.addArrangedSubview(emailField)
        verticalStack.addArrangedSubview(birthDateField)
        verticalStack.addArrangedSubview(saveButton)
        NSLayoutConstraint.activate([
            nameField.widthAnchor.constraint(equalTo: verticalStack.widthAnchor),
            lastNameField.widthAnchor.constraint(equalTo: verticalStack.widthAnchor),
            phoneNumberField.widthAnchor.constraint(equalTo: verticalStack.widthAnchor),
            emailField.widthAnchor.constraint(equalTo: verticalStack.widthAnchor),
            birthDateField.widthAnchor.constraint(equalTo: verticalStack.widthAnchor),
            saveButton.widthAnchor.constraint(equalTo: verticalStack.widthAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Contact"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        setUpUI()
    }
    
    
    @objc func saveTapped() {
        print(#function)
    }
}
