//
//  ChatsPresenter.swift
//  Telegram
//
//  Created by Кирилл on 17.11.2025.
//

import UIKit
import Combine

class ChatsPresenter {
    @Published var chats: [Chat] = []
    var allMessages: [Message] = []
    
    func viewDidLoad() {
        loadMockData()
    }
    
    func loadMockData() {
//        let me = User(
//            id: "me",
//            name: "Кирилл",
//            surname: "Тимешов",
//            photo: UIImage(systemName: "person"),
//            number: "+79215651102",
//            bio: "IOS developer",
//            isOnline: true
//        )
        
        let nikita = User(
            id: "user1",
            name: "Никита",
            surname: "Рудик",
            photo: UIImage(named: "rudik"),
            number: "+79854163937",
            bio: "NLP specialist",
            isOnline: true
        )
        
        let alice = User(
            id: "user2",
            name: "Алиса",
            surname: "Попова",
            photo: UIImage(named: "popova"),
            number: "+79854029567",
            bio: "Working at Lime",
            isOnline: true
        )
        
        let dima = User(
            id: "user3",
            name: "Дима",
            surname: "Жолобов",
            photo: UIImage(named: "zholobov"),
            number: "+79215840391",
            bio: "^_^",
            isOnline: false
        )
        
        let m1 = Message(
            id: "m1",
            text: "Привет! Как дела?",
            date: Date().addingTimeInterval(-5000),
            sender: nikita,
            isRead: true,
            replyTo: nil
        )
        
        let m2 = Message(
            id: "m2",
            text: "Отправила тебе на почту файлы. Проверь, пожалуйста",
            date: Date().addingTimeInterval(-10000),
            sender: alice,
            isRead: false,
            replyTo: nil
        )
        
        let m3 = Message(
            id: "m3",
            text: "Когда устроишься, бомжара?",
            date: Date().addingTimeInterval(-15000),
            sender: dima,
            isRead: true,
            replyTo: nil
        )
        
        let chat1 = Chat(
            id: "chat1",
            userWith: nikita,
            messages: [m1],
            lastMessage: m1,
            unreadCount: 0,
            isMuted: false,
            isPinned: true
        )
        
        let chat2 = Chat(
            id: "chat2",
            userWith: alice,
            messages: [m2],
            lastMessage: m2,
            unreadCount: 1,
            isMuted: false,
            isPinned: true
        )
        
        let chat3 = Chat(
            id: "chat3",
            userWith: dima,
            messages: [m3],
            lastMessage: m3,
            unreadCount: 0,
            isMuted: true,
            isPinned: false
        )
        
        allMessages = [m1, m2, m3]
        
        self.chats = [chat1, chat2, chat3]
    }
    
    private func lastMessage(with user: User, me: User) -> Message {
        return allMessages
            .filter { $0.sender.id == user.id || $0.sender.id == me.id }
            .sorted { $0.date < $1.date }
            .last!
    }
}

