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
    
    var contacts: [DBContact] = []
    var context: NSManagedObjectContext {
        let application = UIApplication.shared
        let appDelegate = application.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
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
        title = "ft_hangouts"
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let fetchRequest = NSFetchRequest<Contact>(entityName: "DBContact")
        let fs = DBContact.fetchRequest()
        
        do {
            let dbContacts = try context.fetch(fs)
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
        let addViewController = AddEditContactViewController(mode: .add)
        navigationController?.pushViewController(addViewController, animated: true)
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("indexPath", indexPath)
        let contactToRemove = contacts[indexPath.row]
        guard
            let cell = tableView.cellForRow(at: indexPath),
            cell.editingStyle == .delete else { return }
        
        context.delete(contactToRemove)
        do {
            try context.save()
            
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
        contacts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension HomepageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        let editViewController = AddEditContactViewController(mode: .edit(contact))
        navigationController?.pushViewController(editViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
