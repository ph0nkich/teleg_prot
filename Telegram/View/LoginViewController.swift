//
//  LoginViewController.swift
//  Telegram
//
//  Created by Кирилл on 18.11.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupNavItems()
    }
    
    // Создаем все компоненты
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 30, weight: .light)
        label.textColor = .label
        label.text = "Your Phone"
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .label
        label.text = "Please confirm your country code and enter your phone number"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let countryCodeTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = .systemFont(ofSize: 22, weight: .light)
        textField.textColor = .label
        textField.text = "USA"
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    private let codeNumberTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = .systemFont(ofSize: 22, weight: .light)
        textField.textColor = .label
        textField.text = "+1"
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    private let numberTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = .systemFont(ofSize: 22)
        textField.textColor = .label
        textField.placeholder = "Your phone number"
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private let topBorderView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let verticalSeparatorView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let bottomBorderView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let syncSwitch: UISwitch = {
        let mySwitch = UISwitch()
        
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.isOn = true
        return mySwitch
    }()
    
    private let syncLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.text = "Sync Contacts"
        label.textColor = .label
        return label
    }()
    
    private let phoneContainter: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private func setupPhoneContainter() {
        phoneContainter.addSubview(countryCodeTextField)
        phoneContainter.addSubview(codeNumberTextField)
        phoneContainter.addSubview(numberTextField)
        phoneContainter.addSubview(topBorderView)
        phoneContainter.addSubview(separatorView)
        phoneContainter.addSubview(verticalSeparatorView)
        phoneContainter.addSubview(bottomBorderView)
        
        
        NSLayoutConstraint.activate([
            topBorderView.topAnchor.constraint(equalTo: phoneContainter.topAnchor),
            topBorderView.leadingAnchor.constraint(equalTo: phoneContainter.leadingAnchor),
            topBorderView.trailingAnchor.constraint(equalTo: phoneContainter.trailingAnchor),
            topBorderView.heightAnchor.constraint(equalToConstant: 1),
            
            countryCodeTextField.topAnchor.constraint(equalTo: topBorderView.bottomAnchor, constant: 10),
            countryCodeTextField.leadingAnchor.constraint(equalTo: phoneContainter.leadingAnchor, constant: 20),
            
            separatorView.topAnchor.constraint(equalTo: countryCodeTextField.bottomAnchor, constant: 10),
            separatorView.leadingAnchor.constraint(equalTo: phoneContainter.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: phoneContainter.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            codeNumberTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            codeNumberTextField.leadingAnchor.constraint(equalTo: countryCodeTextField.leadingAnchor),
            codeNumberTextField.widthAnchor.constraint(equalToConstant: 30),
            verticalSeparatorView.leadingAnchor.constraint(equalTo: codeNumberTextField.trailingAnchor, constant: 10),
            verticalSeparatorView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            verticalSeparatorView.bottomAnchor.constraint(equalTo: bottomBorderView.topAnchor),
            verticalSeparatorView.widthAnchor.constraint(equalToConstant: 1),
            numberTextField.leadingAnchor.constraint(equalTo: verticalSeparatorView.trailingAnchor, constant: 10),
            numberTextField.centerYAnchor.constraint(equalTo: codeNumberTextField.centerYAnchor),
            numberTextField.trailingAnchor.constraint(equalTo: phoneContainter.trailingAnchor),
            
            bottomBorderView.topAnchor.constraint(equalTo: codeNumberTextField.bottomAnchor, constant: 10),
            bottomBorderView.bottomAnchor.constraint(equalTo: phoneContainter.bottomAnchor),
            bottomBorderView.leadingAnchor.constraint(equalTo: phoneContainter.leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: phoneContainter.trailingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(phoneContainter)
        view.addSubview(syncLabel)
        view.addSubview(syncSwitch)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            
            phoneContainter.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            phoneContainter.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            phoneContainter.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            syncLabel.topAnchor.constraint(equalTo: phoneContainter.bottomAnchor, constant: 30),
            syncLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            syncSwitch.topAnchor.constraint(equalTo: phoneContainter.bottomAnchor, constant: 30),
            syncSwitch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        
        setupPhoneContainter()
    }
    
    // Настраиваем кнопки нав бара
    private func setupNavItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextTapped))
    }
    
    @objc func cancelTapped() {
        print("cancel tapped")
    }
    
    @objc func nextTapped() {
        guard let text = numberTextField.text, !text.isEmpty else { return }
        showChats()
    }
    
    private func showChats() {
        let tab = MainTabBarController()
        tab.modalPresentationStyle = .fullScreen
        present(tab, animated: true)
    }
    
}
