//
//  RepoModel.swift
//  searchgit
//
//  Created by Samsud Dhuha on 09/08/21.
//

import Foundation


struct Repo: Decodable {
    var prvt: Bool?
    var nodeId, name, fullName, htmlUrl, description: String?
    var id: Int?
    var owner: DataOwner?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nodeId = "node_id"
        case name = "name"
        case fullName = "full_name"
        case prvt = "private"
        case owner = "owner"
        case htmlUrl = "html_url"
        case description = "description"
    }
}

struct DataOwner: Decodable {
    var login, nodeId, avatarUrl, gravatarId, url, htmlUrl: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url = "url"
        case htmlUrl = "html_url"
    }
}
