//
//  ChatViewController.swift
//  Telegram
//
//  Created by Кирилл on 18.11.2025.
//

import UIKit

class ChatViewController: UIViewController {
    var chat: Chat?
    let currentUser = User(id: "0", name: "Me", surname: "", photo: nil, number: "+1", bio: "", isOnline: true)
    var otherUser: User?
    var messages: [Message] = []
    var inputBarBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        guard let chat = chat else { return }
        otherUser = chat.userWith
        messages = [
            Message(id: "1", text: "Привет, как дела?", date: Date(), sender: User(id: "", name: "", surname: "", photo: nil, number: "", bio: "", isOnline: true), isRead: true, replyTo: nil),
            Message(id: "2", text: "Все заебись", date: Date(), sender: currentUser, isRead: true, replyTo: nil)
        ]
        setupNavBar()
        setupChat()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        updateBackground()
        updateInputBarColors()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // Делаем сверху ник, статус и аватарку
    private func setupNavBar() {
        // Делаем центральную часть
        let nameLabel: UILabel = {
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.text = "\(self.chat?.userWith.name ?? "No") \(self.chat?.userWith.surname ?? "Name")"
            return label
        }()
        
        let statusLabel: UILabel = {
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.font = .systemFont(ofSize: 12, weight: .light)
            label.text = "last seen just now"
            return label
        }()
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.axis = .vertical
            stack.alignment = .center
            stack.addArrangedSubview(nameLabel)
            stack.addArrangedSubview(statusLabel)
            return stack
        }()
        
        let container = UIView()
        container.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        navigationItem.titleView = container
        
        // Делаем аватарку
        let avatar: UIImageView = {
            let imageView = UIImageView()
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.image = chat?.userWith.photo
            imageView.layer.cornerRadius = 18
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            return imageView
        }()
        
        let avatarContainter = UIView()
        avatarContainter.addSubview(avatar)
        NSLayoutConstraint.activate([
            avatarContainter.widthAnchor.constraint(equalToConstant: 36),
            avatarContainter.heightAnchor.constraint(equalToConstant: 36),
            avatar.widthAnchor.constraint(equalTo: avatarContainter.widthAnchor),
            avatar.heightAnchor.constraint(equalTo: avatarContainter.heightAnchor),
            avatar.centerYAnchor.constraint(equalTo: avatarContainter.centerYAnchor),
            avatar.centerXAnchor.constraint(equalTo: avatarContainter.centerXAnchor)
        ])
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: avatarContainter)
        
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    // Делаем сообщения
    let tableView: UITableView = {
        let table = UITableView()
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.identifier)
        table.backgroundColor = .clear
        return table
    }()
    
    // Создаем инпутбар + начинку
    let inputBar: UIView = {
        let input = UIView()
        
        input.translatesAutoresizingMaskIntoConstraints = false
        
        return input
    }()
    
    let attachButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
        return button
    }()
    
    let emojiButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(named: "face.smiling"), for: .normal)
        return button
    }()
    
    let micButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        return button
    }()
            
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.isHidden = true
        return button
    }()
        
    let messageField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Message"
        textField.layer.cornerRadius = 16
        textField.setLeftPaddingPoint(8)
        textField.setRightPaddingPoint(8)
        return textField
    }()
    
    // Пикча на заднем фоне
    let background: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func updateBackground() {
        if traitCollection.userInterfaceStyle == .light {
            background.image = UIImage(named: "light_bg")
        } else {
            background.image = UIImage(named: "dark_bg")
        }
    }
    
    
    // Настраиваем начинку чата
    private func setupChat() {
        
        view.addSubview(background)
        
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 56
        view.addSubview(tableView)
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        messageField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        view.addSubview(inputBar)
        inputBar.addSubview(attachButton)
        inputBar.addSubview(emojiButton)
        inputBar.addSubview(micButton)
        inputBar.addSubview(messageField)
        inputBar.addSubview(sendButton)
        inputBarBottomConstraint = inputBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        inputBarBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            background.leftAnchor.constraint(equalTo: view.leftAnchor),
            background.rightAnchor.constraint(equalTo: view.rightAnchor),
            background.bottomAnchor.constraint(equalTo: inputBar.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputBar.topAnchor),
            
            inputBar.heightAnchor.constraint(equalToConstant: 60),
            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            attachButton.leadingAnchor.constraint(equalTo: inputBar.leadingAnchor, constant: 10),
            attachButton.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 5),
            attachButton.widthAnchor.constraint(equalToConstant: 30),
            attachButton.heightAnchor.constraint(equalToConstant: 30),
            
            messageField.centerXAnchor.constraint(equalTo: inputBar.centerXAnchor),
            messageField.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 5),
            messageField.widthAnchor.constraint(equalToConstant: 300),
            messageField.heightAnchor.constraint(equalToConstant: 33),
            
            emojiButton.trailingAnchor.constraint(equalTo: messageField.trailingAnchor, constant: -8),
            emojiButton.centerYAnchor.constraint(equalTo: messageField.centerYAnchor),
            emojiButton.widthAnchor.constraint(equalToConstant: 20),
            
            micButton.trailingAnchor.constraint(equalTo: inputBar.trailingAnchor, constant: -10),
            micButton.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 5 ),
            micButton.widthAnchor.constraint(equalToConstant: 30),
            micButton.heightAnchor.constraint(equalToConstant: 30),
            
            sendButton.trailingAnchor.constraint(equalTo: inputBar.trailingAnchor, constant: -10),
            sendButton.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 5 ),
            sendButton.widthAnchor.constraint(equalToConstant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    // Настриваем inputBar в зависимости от темы
    private func updateInputBarColors() {
        let isDark = traitCollection.userInterfaceStyle == .dark
        
        if isDark {
            inputBar.backgroundColor = .darkGray
            messageField.backgroundColor = .black
            messageField.textColor = .white
            messageField.attributedPlaceholder = NSAttributedString(string: "Message", attributes: [.foregroundColor: UIColor.systemGray3])
            attachButton.tintColor = .gray
            emojiButton.tintColor = .gray
            micButton.tintColor = .gray
            sendButton.tintColor = .gray
        } else {
            inputBar.backgroundColor = .systemGray6
            messageField.backgroundColor = .white
            messageField.tintColor = .systemGray
            messageField.attributedPlaceholder = NSAttributedString(string: "Message", attributes: [.foregroundColor: UIColor.gray])
            attachButton.tintColor = .systemGray
            emojiButton.tintColor = .systemGray
            micButton.tintColor = .systemGray
            sendButton.tintColor = .systemGray
        }
    }
    
    // Отправка сообщений, не сохраняются при выходе из диалога
    private func sendMessage(_ text: String) {
        let newMessage = Message(
            id: UUID().uuidString,
            text: text,
            date: Date(),
            sender: currentUser,
            isRead: false,
            replyTo: nil)
        
        messages.append(newMessage)
        tableView.reloadData()
    }
    
    @objc func sendTapped() {
        guard let text = messageField.text, !text.isEmpty else { return }
        sendMessage(text)
        messageField.text = ""
        textFieldDidChange(messageField)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let isEmpty = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
        
        self.micButton.isHidden = !isEmpty
        self.sendButton.isHidden = isEmpty
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        guard
            let info = notification.userInfo,
            let frame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        let screenHeight = UIScreen.main.bounds.height
        let keyboardHeight = screenHeight - frame.origin.y
        
        inputBarBottomConstraint.constant = -keyboardHeight
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageCell.identifier, for: indexPath) as! ChatMessageCell
        
        let reversedIndex = messages.count - 1 - indexPath.row
        let message = messages[reversedIndex]
        
        cell.configure(with: message, currentUser: currentUser)
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageCell.identifier, for: indexPath) as! ChatMessageCell
        cell.backgroundColor = .clear
    }
}

extension UITextField {
    func setLeftPaddingPoint(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoint(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
