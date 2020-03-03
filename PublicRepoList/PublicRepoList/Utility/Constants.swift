//
//  Constants.swift
//  PublicRepoList
//
//  Created by Chandrapandian on 2020-03-02.
//  Copyright © 2020 Chandrapandian Jeyaraman. All rights reserved.
//

import Foundation

class Constants {
        
    static let baseUrl: String = "https://api.github.com/repositories"
    
    static let paginationAttribute: String = "?since="
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    static let MAX_LIMIT = 20
    
    static let repoListCellIdentifier: String = "UserListTableViewCellId"
    
    static let Error_Bad_Url = "The given url is not valid"
    
    static let Error_Response_Data_Not_Valid = "There is some problem with server, please contact admin."
    
    static let Error_Parse_Data_Failed = "Problem with parse the data, please contact admin."

    static let Error_Unknown = "Unable to reach server, please try again after some time."
    
}
