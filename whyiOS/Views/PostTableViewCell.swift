//
//  PostTableViewCell.swift
//  whyiOS
//
//  Created by Zachary Frew on 7/18/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit



class PostTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cohortLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    
    // MARK: - Methods
    func updateCell(post: Post) {
        nameLabel.text = post.name
        cohortLabel.text = post.cohort
        reasonLabel.text = post.reason
    }
    
}
