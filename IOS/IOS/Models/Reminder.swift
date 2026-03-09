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

