//
//  ViewExtension.swift
//  PublicRepoList
//
//  Created by Chandrapandian on 2020-03-03.
//  Copyright © 2020 Chandrapandian Jeyaraman. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func circularView() {
        self.layer.cornerRadius = self.frame.size.width/2
    }
    
    func cornerView() {
        self.layer.cornerRadius = 10.0
    }
}
