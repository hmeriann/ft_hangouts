//
//  HomepageViewController.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/8/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit
import ContactsUI

final class HomepageViewController: UIViewController {
    
    var contactList = Contact.defaultContacts()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(HomepageTableViewCell.self, forCellReuseIdentifier: "homepageTableViewCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        
        setUpNavigationBar()
        
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.tintColor = .white

    }
    
    func setUpUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    @objc func addTapped() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        
        contactPicker.predicateForEnablingContact = NSPredicate(format: "emailAddresses.@count > 0")
        present(contactPicker, animated: true, completion: nil)
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .purple
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension HomepageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "homepageTableViewCell", for: indexPath
            ) as? HomepageTableViewCell else { return UITableViewCell()}
        
        cell.configure(with: contactList[indexPath.row])
        return cell
    }
}

extension HomepageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(contactList[indexPath.row].firstName)
//        navigationController?.present(DetailsViewController(with: contacts[indexPath.row].firstName), animated: true)
//        navigationController?.pushViewController(DetailsViewController(with: contacts[indexPath.row]), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        let friendContact = contactList[indexPath.row]
        let contact = friendContact.contactValue
        
        let contactViewController = CNContactViewController(forUnknownContact: contact)
        contactViewController.hidesBottomBarWhenPushed = true
        contactViewController.allowsEditing = false
        contactViewController.allowsActions = false
        navigationController?.navigationBar.tintColor = .lightGray
        navigationController?.pushViewController(contactViewController, animated: true)
    }
}

extension HomepageViewController: CNContactPickerDelegate {
    
    func contactPicker(
        _ picker: CNContactPickerViewController,
        didSelect contacts: [CNContact]
    ) {
        let newContacts = contacts.compactMap { Contact(contact: $0) }
        for contact in newContacts {
            if !contactList.contains(contact) {
                contactList.append(contact)
            }
        }
        tableView.reloadData()
    }
}
