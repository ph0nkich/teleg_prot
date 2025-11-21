//
//  Message.swift
//  Telegram
//
//  Created by Кирилл on 17.11.2025.
//

import Foundation

class Message {
    let id: String
    let text: String
    let date: Date
    let sender: User
    let isRead: Bool
    let replyTo: Message?
    
    init(id: String, text: String, date: Date, sender: User, isRead: Bool, replyTo: Message?) {
        self.id = id
        self.text = text
        self.date = date
        self.sender = sender
        self.isRead = isRead
        self.replyTo = replyTo
    }
}
