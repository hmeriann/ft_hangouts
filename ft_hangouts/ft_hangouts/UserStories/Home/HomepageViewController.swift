//
//  HomepageViewController.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/8/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit

final class HomepageViewController: UIViewController {
    
    let contacts = ["Anna", "Ben", "Byron", "Agness"]
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(HomepageTableViewCell.self, forCellReuseIdentifier: "HomepageTableViewCell")
        table.rowHeight = UITableView.automaticDimension
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}

extension HomepageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomepageTableViewCell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row]
        return cell
    }
}

extension HomepageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(contacts[indexPath.row])
        navigationController?.pushViewController(DetailsViewController(with: contacts[indexPath.row]), animated: false)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
