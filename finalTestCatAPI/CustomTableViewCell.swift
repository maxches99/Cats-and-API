//
//  CustomTableViewCell.swift
//  CatsApp
//
//  Created by Максим Чесников on 12.12.2019.
//  Copyright © 2019 Максим Чесников. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var label: UILabel!
    //    @IBOutlet weak var label: UILabel!
//    @IBOutlet weak var imageView2: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    
        
}


