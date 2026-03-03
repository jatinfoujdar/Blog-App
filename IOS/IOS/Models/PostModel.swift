//
//  PostModel.swift
//  IOS
//
//  Created by jatin foujdar on 03/03/26.
//

import Foundation


struct Post: Codable {
    let id: String?
    let title: String
    let subtitle: String
    let content: String
    let category: String
    let authorEmail: String?
    let createdAt: String?
}

struct CreatePostRequest: Encodable {
    let title: String
    let subtitle: String
    let content: String
    let category: String
}

