//
//  UserListViewModel.swift
//  PublicRepoList
//
//  Created by Chandrapandian on 2020-03-02.
//  Copyright © 2020 Chandrapandian Jeyaraman. All rights reserved.
//

import Foundation
import UIKit

class UserListViewModel {

    var repoList: [User] = []
    
    func getRepoListUrl(atIndex index: Int?, pagination isPagination: Bool ) -> String {
        if isPagination {
            let lastUserIndex = index != nil ? index! : 0
            return Constants.baseUrl + Constants.paginationAttribute + String(self.lastUserId(atIndex: lastUserIndex))
        } else {
            return Constants.baseUrl
        }
    }
    
    func makeServiceCallToLoadRepoList(withUrl urlString: String, completionHandler: @escaping (Bool?, String?) -> Void)  {
        ServiceManager.loadPublicRepoUserList(withUrl: urlString) { result in
            switch result {
            case .success(let repoListData) :
                let fetchedList = Array(repoListData.prefix(Constants.MAX_LIMIT))
                self.repoList = self.repoList + fetchedList
                completionHandler(true, nil)
            case .failure(let error):
                print(error.localizedDescription)
                let errorMessage = ServiceManager.errorHandler(withInfor: error)
                completionHandler(false, errorMessage)
            }
        }
    }
    
    func isLastCell(index: Int) -> Bool {
        return index == self.repoList.count-1 ? true : false
    }
    
    func lastUserId(atIndex index: Int) -> Int {
        return self.repoList[index].id ?? 0
        
    }
    
    func getNumberOfUserInSection() -> Int {
        return repoList.count
    }
    
    func getRowHeight() -> CGFloat {
        return 130.0
    }
    
    func getUserInfo(atIndex index: Int) -> CustomCellViewModel? {
        guard self.repoList.count > index else {
            return nil
        }
        let viewModel = CustomCellViewModel(info: self.repoList[index])
        return viewModel
    }
        
}

