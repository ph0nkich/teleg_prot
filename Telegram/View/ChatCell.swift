//
//  ChatCell.swift
//  Telegram
//
//  Created by Кирилл on 17.11.2025.
//

import UIKit

class ChatCell: UITableViewCell {

    static let identifier = "ChatCell"
    
    // Делаем компоненты ячейки
    private var avatarImageView: UIImageView = {
        let avatar = UIImageView()
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = 30
        avatar.layer.masksToBounds = true
        avatar.backgroundColor = .systemGray5
        return avatar
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let unreadContainer: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.isHidden = true
        return view
    }()
    
    private var unreadNumber: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    private let readStatusImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let pinImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "pin.fill")
        imageView.tintColor = .systemGray3
        imageView.isHidden = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Добавляем на вьюху и устанавливаем констрейты
    private func setupViews() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(unreadContainer)
        unreadContainer.addSubview(unreadNumber)
        contentView.addSubview(readStatusImageView)
        contentView.addSubview(pinImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -10),
            
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            messageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dateLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            
            readStatusImageView.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -5),
            readStatusImageView.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            readStatusImageView.widthAnchor.constraint(equalToConstant: 15),
            readStatusImageView.heightAnchor.constraint(equalToConstant: 15),
            
            unreadContainer.widthAnchor.constraint(equalToConstant: 20),
            unreadContainer.heightAnchor.constraint(equalToConstant: 20),
            unreadContainer.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            unreadContainer.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            
            unreadNumber.centerXAnchor.constraint(equalTo: unreadContainer.centerXAnchor),
            unreadNumber.centerYAnchor.constraint(equalTo: unreadContainer.centerYAnchor),
            
            pinImageView.centerXAnchor.constraint(equalTo: unreadContainer.centerXAnchor),
            pinImageView.centerYAnchor.constraint(equalTo: unreadContainer.centerYAnchor),
            pinImageView.widthAnchor.constraint(equalToConstant: 15),
            pinImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func configuration(with chat: Chat) {
        nameLabel.text = chat.userWith.name
        messageLabel.text = chat.lastMessage.text
        avatarImageView.image = chat.userWith.photo
        
        // Форматируем дату для хорошего отображения
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        dateLabel.text = formatter.string(from: chat.lastMessage.date)
        
        if chat.unreadCount != 0 {
            unreadContainer.isHidden = false
            unreadNumber.isHidden = false
            unreadNumber.text = String(chat.unreadCount)
            pinImageView.isHidden = true
            
            if chat.isMuted {
                unreadContainer.backgroundColor = .systemGray3
            } else {
                unreadContainer.backgroundColor = .systemBlue
            }
            
        } else if chat.isPinned {
            unreadContainer.isHidden = true
            unreadNumber.isHidden = true
            pinImageView.isHidden = false
        } else {
            unreadContainer.isHidden = true
            unreadNumber.isHidden = true
            pinImageView.isHidden = true
        }
    }
    
}
