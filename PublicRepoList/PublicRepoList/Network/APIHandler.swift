//
//  APIHandler.swift
//  PublicRepoList
//
//  Created by Chandrapandian on 2020-03-02.
//  Copyright © 2020 Chandrapandian Jeyaraman. All rights reserved.
//

import Foundation
import UIKit

class ServiceManager {
    
    typealias completionDataType = (Result<[User], ServiceErrorType>) -> ()
    
    static func loadPublicRepoUserList(withUrl urlString: String, complitionHandler: @escaping completionDataType)  {
        guard let repoListUrl = URL(string: urlString) else {
            complitionHandler(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: repoListUrl) { (data, response, error) in
            guard let resultData = data else {
                complitionHandler(.failure(.InvalidData))
                return
            }
            do {
                let jasonDecoder = JSONDecoder()
                let result = try jasonDecoder.decode([User].self, from: resultData)
                complitionHandler(.success(result))
            } catch {
                complitionHandler(.failure(.DataParseError))
            }
        }.resume()
    }
    
    
    static func loadImageWithUrl( urlString: String?, completionHandler: @escaping (UIImage?, Bool) -> Void) {
        
        // setup activityIndicator...
        let finalString = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        //Check the poster url is valid or not
        guard let posterURLString = finalString else {
            completionHandler(nil, false)
            return
        }
        
        guard let url = URL(string: posterURLString) else { return }
        
        // retrieves image if already available in cache
        if let imageFromCache = Constants.imageCache.object(forKey: url as AnyObject) as? UIImage {
            completionHandler(imageFromCache, true)
            return
        }
        
        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {
                    completionHandler(nil, false)
                })
                return
            }
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    Constants.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                    completionHandler(imageToCache, true)
                }
            })
        }).resume()
    }
    
    static func errorHandler(withInfor error: ServiceErrorType) -> String {
        var result: String = ""
        switch error {
        case .badURL:
            result = Constants.Error_Bad_Url
        case .DataParseError:
            result = Constants.Error_Parse_Data_Failed
        case .InvalidData:
            result = Constants.Error_Response_Data_Not_Valid
        default:
            result = Constants.Error_Unknown
            break;
        }
        return result
    }
    
}
