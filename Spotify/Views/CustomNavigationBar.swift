//
//  CustomNavigationBar.swift
//  Spotify
//
//  Created by Dwistari on 15/01/25.
//

import UIKit

class CustomNavigationBar: UIView {
    
    var title: String {
        didSet {
            titleLabel.text = title
        }
    }
    
    var onLeftButtonTap: (() -> Void)?
    var onRightButtonTap: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Initializer
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
           self.title = ""
           super.init(coder: coder)
           setupView()
       }
    
    private func setupView() {
        backgroundColor = .clear

        addSubview(titleLabel)
        titleLabel.text = title
        
        addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        
        addSubview(rightButton)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    @objc private func leftButtonTapped() {
        onLeftButtonTap?()
    }
    
    @objc private func rightButtonTapped() {
        onRightButtonTap?()
    }
}
