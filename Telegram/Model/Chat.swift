//
//  Chat.swift
//  Telegram
//
//  Created by Кирилл on 17.11.2025.
//

import Foundation

struct Chat {
    let id: String
    let userWith: User
    var messages: [Message]
    var lastMessage: Message
    var unreadCount: Int
    var isMuted: Bool
    var isPinned: Bool
}
