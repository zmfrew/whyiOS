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
        presentAddAlertController()
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
    
    // MARK: - Methods
    func presentAddAlertController() {
        let alertController = UIAlertController(title: "Add a Post", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (nameText) in
            nameText.placeholder = "Add name here..."
        }
        
        alertController.addTextField { (cohortText) in
            cohortText.placeholder = "Add cohort here..."
        }
        
        alertController.addTextField { (reasonText) in
            reasonText.placeholder = "Why did you pick iOS?"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text else { return }
            guard let cohort = alertController.textFields?[1].text else { return }
            guard let reason = alertController.textFields?[2].text else { return }
            
            PostController.shared.postReason(name: name, reason: reason, cohort: cohort, completion: { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
