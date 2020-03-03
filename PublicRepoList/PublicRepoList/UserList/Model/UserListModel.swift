//
//  UserListModel.swift
//  PublicRepoList
//
//  Created by Chandrapandian on 2020-03-02.
//  Copyright © 2020 Chandrapandian Jeyaraman. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    var id: Int?
    var name: String?
    var full_name: String?
    var description: String?
    var owner: Owner?
}

struct Owner: Decodable {
    var login: String?
    var id: Int?
    var avatar_url: String?
    var type: String?
    var site_admin: Bool?
    
}


