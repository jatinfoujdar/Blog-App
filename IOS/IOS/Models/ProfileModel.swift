//
//  ProfileModel.swift
//  IOS
//
//  Created by jatin foujdar on 15/02/26.
//

import Foundation


struct Profile: Codable {
    
    let name: String
    let role: String
    let github: String?
    let linkedin: String?
    let twitter: String?
    let website: String?
    
    var socialLinks: [String: String]{
        var links: [String: String] = [:]
        if let github = github, !github.isEmpty {
            links["github"] = github
        }
        if let linkedin = linkedin, !linkedin.isEmpty {
            links["linkedin"] = linkedin
        }
        if let twitter = twitter, !twitter.isEmpty {
            links["twitter"] = twitter
        }
        if let website = website, !website.isEmpty {
            links["website"] = website
        }
        return links
    }
}
