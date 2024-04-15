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
    
    // MARK: UI
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .secondarySystemBackground
        return scrollView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        return stackView
    }()
    
    private let profileHeaderView = ProfileHeaderView()
    
    // Buttons
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 16
        return stack
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
    
    // Phone number
    private lazy var phoneNumberView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle(String(localized: " Delete contact"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let contact: DBContact
    // MARK: MFMessageComposeViewControllerDelegate, CNContactViewControllerDelegate variables
    private let store = CNContactStore()
    
    // MARK: CoreData variable
    private var context: NSManagedObjectContext {
        let application = UIApplication.shared
        let appDelegate = application.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    // MARK: - Init
    init(for contact: DBContact) {
        self.contact = contact
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure(with: contact)
    }
    
    // MARK: - Set Up UI
    
    private func setUpUI() {
        setUpScrollView()
        setUpBackgroundView()
        setUpMainStackView()
        setUpProfileHeaderView()
        setUpButtons()
        setUpPhoneNumberView()
        setUpDeleteButton()
    }
    
    private func setUpScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
    private func setUpBackgroundView() {
        scrollView.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 36),
            backgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            backgroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
        ])
    }
    
    private func setUpMainStackView() {
        backgroundView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -24),
        ])
    }
    
    private func setUpProfileHeaderView() {
        mainStackView.addArrangedSubview(profileHeaderView)
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Why constant?
            profileHeaderView.heightAnchor.constraint(equalToConstant: 300),
            // to set the width of the stackView
            profileHeaderView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            profileHeaderView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    private func setUpButtons() {
        mainStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(sendMessageButton)
        buttonsStackView.addArrangedSubview(makeCallButton)
    }
    
    private func setUpPhoneNumberView() {
        mainStackView.addArrangedSubview(phoneNumberView)
        phoneNumberView.addSubview(phoneNumberLabel)
        NSLayoutConstraint.activate([
            phoneNumberLabel.leadingAnchor.constraint(equalTo: phoneNumberView.leadingAnchor, constant: 16),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: phoneNumberView.trailingAnchor, constant: -16),
            phoneNumberLabel.topAnchor.constraint(equalTo: phoneNumberView.topAnchor, constant: 16),
            phoneNumberLabel.bottomAnchor.constraint(equalTo: phoneNumberView.bottomAnchor, constant: -16),
            
            phoneNumberView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
    }
    
    private func setUpDeleteButton() {
        mainStackView.addArrangedSubview(deleteButton)
    }
    
    private func configure(with contact: DBContact) {
        guard
            case let name = contact.firstName,
            let lastName = contact.lastName
        else { return }
        
        profileHeaderView.profileNameLabel.text = name + " " + lastName
        if let imageData = contact.userPicture {
            profileHeaderView.userPicure.image = UIImage(data: imageData)
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
