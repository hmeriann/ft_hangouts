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
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(HomepageTableViewCell.self, forCellReuseIdentifier: "homepageTableViewCell")
        table.backgroundColor = .secondarySystemBackground
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: "ft_hangouts")
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
        
        let setColorImage = UIImage(systemName: "paintbrush.fill")
        let setHeaderColorButton = UIButton(type: .system)
        setHeaderColorButton.setImage(setColorImage, for: .normal)
        setHeaderColorButton.addTarget(self, action: #selector(setHeaderColorTapped), for: .touchUpInside)
        let setColorBarButtonItem = UIBarButtonItem(customView: setHeaderColorButton)
        navigationItem.leftBarButtonItem = setColorBarButtonItem
        
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
    
    @objc func setHeaderColorTapped() {
        
        presentColorPicker()
        
        let alert = UIAlertController(title: "Choose new color for header", message: nil, preferredStyle: .actionSheet)
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = String(localized: "Choose new color for header")
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        alert.addChild(colorPicker)
        
        if let popoverController = alert.popoverPresentationController {
                popoverController.barButtonItem = self.navigationItem.rightBarButtonItem
            }
        
        present(alert, animated: true, completion: nil)
    }
    
    func presentColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "Background Color"
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
        self.present(colorPicker, animated: true)
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
        
        let overviewContact = OverviewContactViewController(for: contact)
        navigationController?.pushViewController(overviewContact, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomepageViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        
        print("\(selectedColor)")
        dismiss(animated: true)
    }
}
