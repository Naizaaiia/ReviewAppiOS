//
//  ReviewTableViewCell.swift
//  Review
//
//  Created by Naizaa Inwonderland on 9/12/2560 BE.
//  Copyright © 2560 Naizaa Inwonderland. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblComment: UILabel!
    
    @IBOutlet weak var lblScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
