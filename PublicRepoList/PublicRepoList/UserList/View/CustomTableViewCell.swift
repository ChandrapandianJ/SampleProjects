//
//  CustomTableViewCell.swift
//  PublicRepoList
//
//  Created by Chandrapandian on 2020-03-02.
//  Copyright © 2020 Chandrapandian Jeyaraman. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var authorName: UILabel?
    @IBOutlet weak var descriptionLbl: UILabel?
    @IBOutlet weak var avatarImageView: UIImageView?
    @IBOutlet weak var spinner: UIActivityIndicatorView?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurationCell(withInfo viewModel: CustomCellViewModel?) {
        guard let cellViewModel = viewModel else {
            return
        }
        self.name?.text = cellViewModel.repoName
        self.descriptionLbl?.text = cellViewModel.descriptionText
        self.authorName?.text = cellViewModel.authorName
        
        self.avatarImageView?.image = UIImage(named: "placeholder")
        self.spinner?.startAnimating()
        self.spinner?.isHidden = false
        
        self.avatarImageView?.circularView()
        cellViewModel.loadImage(withUrl: cellViewModel.avatarIamgeUrl) { (avatarImage) in
            self.avatarImageView?.image = avatarImage
            self.spinner?.stopAnimating()
            self.spinner?.isHidden = true
        }
        
    }
}
