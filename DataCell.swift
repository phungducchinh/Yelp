//
//  DataCell.swift
//  Yelp
//
//  Created by phungducchinh on 7/2/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {

    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var distanceImg: UIImageView!
    
    var isCheck: Bool = false {
        didSet {
            distanceImg.isHidden = !(isCheck)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(name: String, isCheck: Bool) {
        nameLb.text = name
        self.isCheck = isCheck
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
}
