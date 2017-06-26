//
//  SwitchCell.swift
//  Yelp
//
//  Created by phungducchinh on 6/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol switchCellDelegate{
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!

    var delegate: switchCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        print("change to \(sender.isOn)")
        delegate.switchCell(switchCell: self, didChangeValue: sender.isOn)
    }
    

}
