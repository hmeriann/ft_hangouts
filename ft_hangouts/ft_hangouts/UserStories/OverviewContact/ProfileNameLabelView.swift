//
//  ProfileNameLabelView.swift
//  ft_hangouts
//
//  Created by Zuleykha Pavlichenkova on 13.04.2024.
//  Copyright © 2024 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit

final class ProfileNameLabelView: UILabel {
    // MARK: - Properties
    override var text: String? {
        didSet {
            guard let words = text?.components(separatedBy: .whitespaces) else { return }
            let joinedWords = words.joined(separator: "\n")
            guard text != joinedWords else { return }
            DispatchQueue.main.async { [weak self] in
                self?.text = joinedWords
            }
        }
    }
    
    // MARK: - Initializers
    init(fullName: String? = "Full Name") {
        super.init(frame: .zero)
        setTextAttributes()
        self.text = fullName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up Views
    private func setTextAttributes() {
        numberOfLines = 0
        textAlignment = .center
        font = UIFont.boldSystemFont(ofSize: 24)
    }
    
}
