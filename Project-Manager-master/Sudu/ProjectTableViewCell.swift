//
//  ProjectTableViewCell.swift
//  Sudu
//
//  Created by xiwei feng on 12/5/15.
//  Copyright © 2015 xiwei feng. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    // Mark: Properties
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
