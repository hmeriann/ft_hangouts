//
//  AddContactViewController.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/11/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit
import CoreData

enum ContactViewMode {
    case add
    case edit(Contact)
}

final class AddContactViewController: UIViewController {
    
    var context: NSManagedObjectContext {
        let application = UIApplication.shared
        let appDelegate = application.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    // MARK: UI
    
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
    
    private lazy var addUserPictureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add user picture", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addPictureButtonTapped), for: .touchUpInside)
        return button
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
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    // MARK: Init
    
    private let mode: ContactViewMode
    
    init(mode: ContactViewMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        scrollView.addSubview(userPicure)
        scrollView.addSubview(addUserPictureButton)
        NSLayoutConstraint.activate([
            userPicure.heightAnchor.constraint(equalToConstant: 150),
            userPicure.widthAnchor.constraint(equalToConstant: 150),
            userPicure.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            userPicure.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            addUserPictureButton.topAnchor.constraint(equalTo: userPicure.bottomAnchor),
            addUserPictureButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        scrollView.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            verticalStack.topAnchor.constraint(equalTo: addUserPictureButton.bottomAnchor, constant: 16),
            verticalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant:  16),
            verticalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            verticalStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
        ])
        verticalStack.addArrangedSubview(nameField)
        verticalStack.addArrangedSubview(lastNameField)
        verticalStack.addArrangedSubview(phoneNumberField)
        verticalStack.addArrangedSubview(emailField)
        verticalStack.addArrangedSubview(horizontalStack)
        horizontalStack.addArrangedSubview(birthDateLabel)
        horizontalStack.addArrangedSubview(birthDatePicker)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configure()
    }
    
    func configure() {
        switch mode {
        case .add:
            title = "Add New Contact"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(createContact))
            
        case .edit(let contact):
            title = "Edit Contact"
            show(contact: contact)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveContact))
        }
    }
    
    @objc func addPictureButtonTapped() {
        print(#function)
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func createContact() {
        
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)!
        let contact = Contact(entity: entity, insertInto: context)
        contact.contactId = UUID()
        contact.firstName = nameField.text ?? ""
        contact.lastName = lastNameField.text ?? ""
        contact.phoneNumber = phoneNumberField.text ?? ""
        contact.email = emailField.text ?? ""
        contact.birthDate = birthDatePicker.date
//        contact.userPicture = Data(from: <#T##Decoder#>)
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)

        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
    
    @objc func saveContact() {
        print(#function)
        guard case let ContactViewMode.edit(contact) = mode else { fatalError() }
        contact.firstName = nameField.text ?? ""
        contact.lastName = lastNameField.text ?? ""
        contact.phoneNumber = phoneNumberField.text ?? ""
        contact.email = emailField.text ?? ""
        contact.birthDate = birthDatePicker.date
        contact.userPicture = userPicure.image?.pngData()
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
    
    func show(contact: Contact) {
        nameField.text = contact.firstName
        lastNameField.text = contact.lastName
        if let imageData = contact.userPicture {
            userPicure.image = UIImage(data: imageData)
        }
        emailField.text = contact.email
        phoneNumberField.text = contact.phoneNumber
        if let birthDate = contact.birthDate {
            birthDatePicker.date = birthDate
        }
    }
}

extension AddContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userPicure.image = selectedImage
            
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
