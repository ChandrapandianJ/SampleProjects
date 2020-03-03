//
//  CustomCellViewModel.swift
//  PublicRepoList
//
//  Created by Chandrapandian on 2020-03-03.
//  Copyright © 2020 Chandrapandian Jeyaraman. All rights reserved.
//

import Foundation
import UIKit


struct CustomCellViewModel {
    
    private let userInfo: User
    
    init(info: User) {
        self.userInfo = info
    }
    
    var repoName: String {
        return self.userInfo.name?.capitalized ?? ""
    }
    
    var repoId: String {
        return (self.userInfo.id != nil) ? "Id - \(String(describing: self.userInfo.id!))" : ""
    }
    
    var descriptionText: String {
        return self.userInfo.description ?? ""
    }
    
    var avatarIamgeUrl: String {
        return self.userInfo.owner?.avatar_url ?? ""
    }
    
    var userType: String {
        return self.userInfo.owner?.type ?? ""
    }
    
    var authorName: String{
        return self.userInfo.owner?.login?.capitalized ?? ""
    }
    
    
    
    func loadImage(withUrl urlString: String, compeletionCallBack: @escaping (UIImage) -> Void) {
        ServiceManager.loadImageWithUrl(urlString: urlString, completionHandler: { (posterImage, result) in
            if result == true {
                compeletionCallBack(posterImage!)
            } else {
                compeletionCallBack(UIImage(named: "placeholder")!)
            }
        })
    }
    
}
