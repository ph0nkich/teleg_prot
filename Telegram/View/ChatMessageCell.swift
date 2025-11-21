//
//  ChatMessageCell.swift
//  Telegram
//
//  Created by Кирилл on 19.11.2025.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    
    static let identifier = "ChatMessageCell"
    // Разделение на левое и правое сообщения
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!

    let bubbleView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 16
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 10, weight: .ultraLight)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        bubbleView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.75),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 6),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -10),
            
            timeLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 4),
            timeLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -10),
            timeLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -6)
        ])
        
        leadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        trailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
    }
    
    func configure(with message: Message, currentUser: User) {
        messageLabel.text = message.text
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel.text = formatter.string(from: message.date)
        
        let isIncoming = message.sender.id != currentUser.id
        let isDark = traitCollection.userInterfaceStyle == .dark
        
        // Настраиваем под тему
        if isIncoming {
            bubbleView.backgroundColor = isDark ? .black : .white
            messageLabel.textColor = isDark ? .white : .black
        } else {
            bubbleView.backgroundColor = isDark ? .darkGray : .systemGreen
            messageLabel.textColor = isDark ? .white : .black
        }
        
        leadingConstraint.isActive = isIncoming
        trailingConstraint.isActive = !isIncoming
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
