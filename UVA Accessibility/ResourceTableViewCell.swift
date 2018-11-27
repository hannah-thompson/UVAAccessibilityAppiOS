//
//  ResourceTableViewCell.swift
//  UVA Accessibility
//
//  Created by Hannah Marie Thompson on 11/23/18.
//  Copyright © 2018 Hannah Marie Thompson. All rights reserved.
//

import UIKit

class ResourceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resourceItemNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
