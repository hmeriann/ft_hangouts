//
//  AddEditContactViewController.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/11/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit
import CoreData

enum ContactViewMode {
    case add
    case edit(DBContact)
}

final class AddEditContactViewController: UIViewController {
    
    // MARK: CoreData variable
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
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .tertiarySystemBackground
        
        return view
    }()
    
    private lazy var userPicure: UIImageView = {
        let userpic = UIImageView()
        userpic.translatesAutoresizingMaskIntoConstraints = false
        userpic.contentMode = .scaleAspectFill
        userpic.layer.cornerRadius = 75
        userpic.clipsToBounds = true
        userpic.tintColor = .secondarySystemBackground
        userpic.image = UIImage(systemName: "person.crop.circle.fill")
        return userpic
    }()
    
    private lazy var addUserPictureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String(localized: "Add user picture"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addPictureButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 20)
        field.borderStyle = .roundedRect
        field.backgroundColor = .secondarySystemBackground
        field.textColor = .secondaryLabel
        field.placeholder = String(localized: "First name")
        field.clearButtonMode = .whileEditing
        return field
    }()
    
    private lazy var lastNameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 20)
        field.borderStyle = .roundedRect
        field.backgroundColor = .secondarySystemBackground
        field.textColor = .secondaryLabel
        field.placeholder = String(localized: "Last name")
        field.clearButtonMode = .whileEditing

        return field
    }()
    
    private lazy var phoneNumberField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 20)
        field.borderStyle = .roundedRect
        field.backgroundColor = .secondarySystemBackground
        field.textColor = .secondaryLabel
        field.placeholder = String(localized: "Phone number")
        field.clearButtonMode = .whileEditing

        return field
    }()
    
    private lazy var emailField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 20)
        field.borderStyle = .roundedRect
        field.backgroundColor = .secondarySystemBackground
        field.textColor = .secondaryLabel
        field.placeholder = String(localized: "Email")
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
        label.text = String(localized: "Birth date")
        label.font = .systemFont(ofSize: 20)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: - Init
    private let mode: ContactViewMode
    
    init(mode: ContactViewMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        
        setUpScrollView()
        setUpBackgroundView()
        setUpFields()
    }
    
    func setUpScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
    func setUpBackgroundView() {
        scrollView.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 36),
            backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            backgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    func setUpFields() {
        backgroundView.addSubview(userPicure)
        backgroundView.addSubview(addUserPictureButton)
        NSLayoutConstraint.activate([
            userPicure.heightAnchor.constraint(equalToConstant: 150),
            userPicure.widthAnchor.constraint(equalToConstant: 150),
            userPicure.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            userPicure.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            
            addUserPictureButton.topAnchor.constraint(equalTo: userPicure.bottomAnchor),
            addUserPictureButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        backgroundView.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, constant: -48),
            verticalStack.topAnchor.constraint(equalTo: addUserPictureButton.bottomAnchor, constant: 24),
            verticalStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant:  24),
            verticalStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),
            verticalStack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -24),
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
            title = String(localized: "Add New Contact")
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addContactTapped))
            
        case .edit(let contact):
            title = String(localized: "Edit Contact")
            show(dbContact: contact)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveContactAfterEditing))
        }
    }
    
    @objc func addPictureButtonTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func addContactTapped() {
        let validationResult = isEnteredDataValid()
        
        if validationResult.isEmpty {
            createDBContact()
        } else {
            showError(errors: validationResult)
        }
    }
    
    private func isEnteredDataValid() -> [UserDataValidatingError] {
        
        var errors: [UserDataValidatingError] = []
        let validator = UserDataValidator()

        // check userName
        if let userName = nameField.text, !userName.isEmpty {
            if !validator.validate(userName: userName) {
                errors.append(.userNameIsInvalid)
            }
        } else {
            errors.append(.userNameIsEmpty)
        }
        // check phone
        if let phone = phoneNumberField.text, !phone.isEmpty {
            if !validator.validate(phone: phone) {
                errors.append(.phoneIsInvalid)
            }
        } else {
            errors.append(.phoneIsEmpty)
        }
        // check email
        if let email = emailField.text, !email.isEmpty {
            if !validator.validate(email: email) {
                errors.append(.emailIsInvalid)
            }
        } else {
            errors.append(.emailIsEmpty)
        }
        return errors
    }
    
    private func showError(errors: [UserDataValidatingError]) {
        var alertMessage: String = ""
        for error in errors {
            alertMessage += "\n\(error.message)."
        }
        let alert = UIAlertController(
            title: String(localized: "Error"),
            message: alertMessage,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: nil
        )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func createDBContact() {
        
        let entity = NSEntityDescription.entity(forEntityName: "DBContact", in: context)!
        let dbContact = DBContact(entity: entity, insertInto: context)
        dbContact.contactId = UUID()
        setValues(to: dbContact)
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)

        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
    
    @objc func saveContactAfterEditing() {
        
        let validationResult = isEnteredDataValid()
        
        if validationResult.isEmpty {
            saveUpdatedContact()
        } else {
            showError(errors: validationResult)
        }
    }
    
    private func saveUpdatedContact() {
        
        guard case let ContactViewMode.edit(dbContact) = mode else { fatalError() }
        setValues(to: dbContact)
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
    
    private func setValues(to dbContact: DBContact) {
        dbContact.firstName = nameField.text ?? ""
        dbContact.lastName = lastNameField.text ?? ""
        dbContact.phoneNumber = phoneNumberField.text ?? ""
        dbContact.email = emailField.text ?? ""
        dbContact.birthDate = birthDatePicker.date
        dbContact.userPicture = userPicure.image?.pngData()
    }
    
    func show(dbContact: DBContact) {
        nameField.text = dbContact.firstName
        lastNameField.text = dbContact.lastName
        if let imageData = dbContact.userPicture {
            userPicure.image = UIImage(data: imageData)
        }
        emailField.text = dbContact.email
        phoneNumberField.text = dbContact.phoneNumber
        if let birthDate = dbContact.birthDate {
            birthDatePicker.date = birthDate
        }
    }
}

// MARK: - Image Picker Delegate Methods
extension AddEditContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
