//
//  PostModel.swift
//  IOS
//
//  Created by jatin foujdar on 03/03/26.
//

import Foundation


struct PostModel : Codable, Identifiable {
    
    var id: String?
    var title: String
    var subtitle: String
    var content: String
    var authorEmail: String
    var createdAt: Date?
    var updatedAt: Date?
}
