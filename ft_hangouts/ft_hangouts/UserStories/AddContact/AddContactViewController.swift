//
//  AddContactViewController.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/11/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit
import CoreData

final class AddContactViewController: UIViewController {
    
    var contacts: [NSManagedObject] = []
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
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
    
    private lazy var birthDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .date
        return picker
    }()

    private lazy var birthDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Birth date"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
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
        stack.alignment = .fill
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
        scrollView.addSubview(userPicure)
        NSLayoutConstraint.activate([
            userPicure.heightAnchor.constraint(equalToConstant: 150),
            userPicure.widthAnchor.constraint(equalToConstant: 150),
            userPicure.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            userPicure.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
        scrollView.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            verticalStack.topAnchor.constraint(equalTo: userPicure.bottomAnchor, constant: 16),
            verticalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant:  16),
            verticalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            verticalStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
        ])
        verticalStack.addArrangedSubview(nameField)
        verticalStack.addArrangedSubview(lastNameField)
        verticalStack.addArrangedSubview(phoneNumberField)
        verticalStack.addArrangedSubview(emailField)
        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(saveButton)
        horizontalStack.addArrangedSubview(birthDateLabel)
        horizontalStack.addArrangedSubview(birthDatePicker)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Contact"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        setUpUI()
    }
    
    
    @objc func saveTapped() {
        let application = UIApplication.shared
        guard let appDelegate = application.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedContext)!
        let contact = NSManagedObject(entity: entity, insertInto: managedContext)
        contact.setValue(UUID(), forKey: "contactId")
        contact.setValue(nameField.text, forKey: "firstName")
        contact.setValue(lastNameField.text, forKey: "lastName")
//        contact.setValue(userPicure.image, forKey: "userPicture")
        contact.setValue(emailField.text, forKey: "email")
        contact.setValue(phoneNumberField.text, forKey: "phoneNumber")
        contact.setValue(birthDatePicker.date, forKey: "birthDate")
        do {
            try managedContext.save()
            contacts.append(contact)
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
}
