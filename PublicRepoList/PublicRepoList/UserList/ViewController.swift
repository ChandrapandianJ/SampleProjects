//
//  ViewController.swift
//  PublicRepoList
//
//  Created by Chandrapandian on 2020-03-02.
//  Copyright © 2020 Chandrapandian Jeyaraman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = UserListViewModel()
    @IBOutlet weak var listTableView: UITableView?
    @IBOutlet weak var spinnerBackgroundView: UIView?
    @IBOutlet weak var spinnerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.spinnerView?.cornerView()
        self.makeServiceCallToLoadRepoList(atIndex: nil, pagination: false)
    }
    
    func makeServiceCallToLoadRepoList(atIndex index: Int?, pagination isFresh: Bool ) {
        self.spinnerBackgroundView?.isHidden = false
        
        let url = self.viewModel.getRepoListUrl(atIndex: index, pagination: isFresh)
        viewModel.makeServiceCallToLoadRepoList(withUrl: url) { (success, errorMessage) in
            DispatchQueue.main.async {
                self.spinnerBackgroundView?.isHidden = true
                if success ?? false {
                    self.listTableView?.reloadData()
                } else {
                    let alertViewController = UIAlertController.init(title: "Error", message: errorMessage, preferredStyle: .alert)
                    self.present(alertViewController, animated: true, completion: nil)
                }
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfUserInSection()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.getRowHeight()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.repoListCellIdentifier, for: indexPath) as! CustomTableViewCell
        let cellViewModel = viewModel.getUserInfo(atIndex: indexPath.row)
        cell.configurationCell(withInfo: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.viewModel.isLastCell(index: indexPath.row) {
            print(indexPath.row)
            self.makeServiceCallToLoadRepoList(atIndex: indexPath.row, pagination: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewControllerIdentifier") as! UserDetailsViewController
        viewController.userViewModel = self.viewModel.getUserInfo(atIndex: indexPath.row)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

