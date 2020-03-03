//
//  UserDetailsViewController.swift
//  PublicRepoList
//
//  Created by Chandrapandian on 2020-03-03.
//  Copyright © 2020 Chandrapandian Jeyaraman. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    var userViewModel: CustomCellViewModel?
    
    @IBOutlet weak var authorName: UILabel?
    @IBOutlet weak var repoName: UILabel?
    @IBOutlet weak var id: UILabel?
    @IBOutlet weak var descriptionLbl: UILabel?
    @IBOutlet weak var avatarImageView: UIImageView?
    @IBOutlet weak var userType: UILabel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.id?.text = userViewModel?.repoId
        self.authorName?.text = userViewModel?.authorName
        self.repoName?.text = userViewModel?.repoName
        self.descriptionLbl?.text = userViewModel?.descriptionText
        self.userType?.text = userViewModel?.userType
        
        self.avatarImageView?.circularView()
        self.avatarImageView?.image = UIImage(named: "placeholder")
        userViewModel?.loadImage(withUrl: self.userViewModel?.avatarIamgeUrl ?? "", compeletionCallBack: { (avatarImage) in
            self.avatarImageView?.image = avatarImage
        })
    }
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
