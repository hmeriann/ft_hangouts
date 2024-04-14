//
//  OverviewContactViewController.swift
//  ft_hangouts
//
//  Created by Zuleykha Pavlichenkova on 31.03.2024.
//  Copyright © 2024 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit
import CoreData
import MessageUI
import ContactsUI

final class OverviewContactViewController: UIViewController, MFMessageComposeViewControllerDelegate, CNContactViewControllerDelegate {

    private let contact: DBContact
    private let profileHeaderView = ProfileHeaderView()
    private let mainStackView = UIStackView()
    private let scrollView = UIScrollView()
    
    // MARK: MFMessageComposeViewControllerDelegate, CNContactViewControllerDelegate variables
    let store = CNContactStore()
    
    // MARK: CoreData variable
    var context: NSManagedObjectContext {
        let application = UIApplication.shared
        let appDelegate = application.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    // MARK: UI
//    private lazy var scrollView: UIScrollView = {
//        let view = UIScrollView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.isScrollEnabled = true
//        view.backgroundColor = .secondarySystemBackground
//        return view
//    }()
    
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
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        return label
    }()
    
    private lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        return label
    }()
    
    private lazy var sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let boldMessage = UIImage(systemName: "message", withConfiguration: boldConfig)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle(String(localized: " Send message"), for: .normal)
        button.setImage(boldMessage, for: .normal)
        button.addTarget(self, action: #selector(sendMessagePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var makeCallButton: UIButton = {
        let button = UIButton(type: .system)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let boldMessage = UIImage(systemName: "phone", withConfiguration: boldConfig)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle(String(localized: " Make a call"), for: .normal)
        button.setImage(boldMessage, for: .normal)
        button.addTarget(self, action: #selector(makeACallPressed), for: .touchUpInside)
        return button
    }()

    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .secondaryLabel
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
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle(String(localized: " Delete contact"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    init(for contact: DBContact) {
        self.contact = contact
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up UI
    
    private func setUpProfileHeaderView() {
        mainStackView.addArrangedSubview(profileHeaderView)
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileHeaderView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setUpUI() {
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        
        setUpProfileHeaderView()
//        
//        
        mainStackView.addSubview(horizontalStack)
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: 16),
            horizontalStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        horizontalStack.addArrangedSubview(sendMessageButton)
        horizontalStack.addArrangedSubview(makeCallButton)
//
//        scrollView.addSubview(verticalStack)
//        NSLayoutConstraint.activate([
//            verticalStack.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 32),
//            verticalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant:  32),
//            verticalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
//            verticalStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -32)
//        ])
//
        mainStackView.addArrangedSubview(phoneNumberLabel)

        mainStackView.addArrangedSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 24),
            deleteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure(with: contact)
    }
    
    func configure(with contact: DBContact) {
        guard
            case let name = contact.firstName,
            let lastName = contact.lastName
        else { return }
        
        profileHeaderView.profileNameLabel.text = name + " " + lastName
        if let imageData = contact.userPicture {
            userPicure.image = UIImage(data: imageData)
        }
        if let phoneNumber = contact.phoneNumber {
            phoneNumberLabel.text = phoneNumber
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onEditTapped))
    }
    
    // MARK: - Buttons Actions
    @objc func onEditTapped() {
        let editViewController = AddEditContactViewController(mode: .edit(contact))
        navigationController?.pushViewController(editViewController, animated: true)
    }
    
    @objc func sendMessagePressed() {
        if !MFMessageComposeViewController.canSendText() {
            print("SMS services are not available.")
        }
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        composeVC.recipients = ["+\(phoneNumberLabel.text!)"]
        composeVC.body = ""
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        // Dismiss the message compose view controller.
        controller.dismiss(animated: true, completion: nil)}

    
    @objc func makeACallPressed() {
        if let url = URL(string: "tel://" + phoneNumberLabel.text!) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func deleteButtonPressed() {
        showConfirmation()
    }
    
    private func showConfirmation() {
        let alert = UIAlertController(
            title: "",
            message: String(localized: "Delete immediately - \(contact.firstName)"),
            preferredStyle: .alert
        )
        let deleteAction = UIAlertAction(
            title: String(localized: "Delete"),
            style: .destructive,
            handler: {_ in
                self.context.delete(self.contact)
                do {
                    try self.context.save()
                } catch {
                    print("Couldn't delete the contact. \(error)")
                }
                self.navigationController?.popViewController(animated: true)
            }
        )
        
        let cancelAction = UIAlertAction(
//            title: "Cancel",
            title: String(localized: "Cancel"),
            style: .cancel,
            handler: nil
        )
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
