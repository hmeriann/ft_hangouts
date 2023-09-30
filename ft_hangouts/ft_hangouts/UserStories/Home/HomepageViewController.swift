//
//  HomepageViewController.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/8/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit
import CoreData

final class HomepageViewController: UIViewController {
    
    var contacts: [Contact] = []
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
//        table.delegate = self
        table.register(HomepageTableViewCell.self, forCellReuseIdentifier: "homepageTableViewCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ft_hangouts"
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<Contact>(entityName: "Contact")
        let fs = Contact.fetchRequest()
        
        do {
            let dbContacts = try managedContext.fetch(fs)
            contacts = dbContacts
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    func setUpUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    @objc func addTapped() {
        navigationController?.pushViewController(AddContactViewController(), animated: true)
    }
}

extension HomepageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contact = contacts[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "homepageTableViewCell", for: indexPath
            ) as? HomepageTableViewCell else { return UITableViewCell()}
        
        cell.configure(with: contact)
        return cell
    }
}

//extension HomepageViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        print(contacts[indexPath.row].firstName)
////        navigationController?.present(DetailsViewController(with: contacts[indexPath.row].firstName), animated: true)
//        navigationController?.pushViewController(DetailsViewController(with: contacts[indexPath.row]), animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
