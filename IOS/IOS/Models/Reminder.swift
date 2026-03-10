//
//  Reminder.swift
//  IOS
//
//  Created by jatin foujdar on 06/03/26.
//

import Foundation

struct Task: Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
}

extension Task{
    static func save(_ task: [Task]){
        if let encoded = try? JSONEncoder().encode(task){
            UserDefaults.standard.set(encoded, forKey: "saved_tasks")
        }
    }
    static func load()-> [Task]{
        if let data = UserDefaults.standard.data(forKey: "saved_tasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data){
            return decoded
        }
        return[]
    }
}
