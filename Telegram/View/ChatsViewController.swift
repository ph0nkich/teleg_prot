//
//  ChatsViewController.swift
//  Telegram
//
//  Created by Кирилл on 17.11.2025.
//

import UIKit
import Combine

class ChatsViewController: UIViewController {
    
    var chatPresenter: ChatsPresenter!
    private var cancellables = Set<AnyCancellable>()
    private var chats: [Chat] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatPresenter = ChatsPresenter()

        setupBindings()
        chatPresenter.viewDidLoad()
        setupUI()
        setupNavBar()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else { return }

        let isDark = traitCollection.userInterfaceStyle == .dark
        let tint: UIColor = isDark ? .white : .systemBlue

        navigationController?.navigationBar.tintColor = tint

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        appearance.titleTextAttributes = [.foregroundColor: tint]
        appearance.largeTitleTextAttributes = [.foregroundColor: tint]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        view.setNeedsLayout()
        view.layoutIfNeeded()
    }


    private func setupBindings() {
        chatPresenter.$chats
            .receive(on: DispatchQueue.main)
            .sink { chats in
                self.chats = chats
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Chats"
        
        view.addSubview(tableView)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 36))
        searchBar.frame = headerView.bounds
        headerView.addSubview(searchBar)
        tableView.tableHeaderView = headerView
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.identifier)
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeTapped))
    }
    
    @objc func editTapped() {
        print("Edit tapped")
    }
    
    @objc func composeTapped() {
        print("Compose tapped")
    }
    
    // Серч бар
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search for message or users"
        bar.searchBarStyle = .minimal
        return bar
    }()
    
}

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell else { return UITableViewCell() }
        
        let chat = chats[indexPath.row]
        
        cell.configuration(with: chat)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChat = chats[indexPath.row]
        let vc = ChatViewController()
        vc.chat = selectedChat
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
