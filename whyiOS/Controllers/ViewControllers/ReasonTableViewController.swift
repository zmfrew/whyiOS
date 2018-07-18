//
//  ReasonTableViewController.swift
//  whyiOS
//
//  Created by Zachary Frew on 7/18/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class ReasonTableViewController: UITableViewController {

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
    
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        PostController.shared.fetchPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = PostController.shared.posts[indexPath.row]
        cell.updateCell(post: post)
        return cell
    }

}
