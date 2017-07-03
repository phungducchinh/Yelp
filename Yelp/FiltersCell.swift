//
//  FiltersCell.swift
//  Yelp
//
//  Created by phungducchinh on 6/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
protocol FiltersCellDelegate {
    func filtersCellDelegate(filterCell: FiltersCell, didValueChange value : Bool)
    
    
}
class FiltersCell: UITableViewCell {

    @IBOutlet weak var catogoriesLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    var delegate : FiltersCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        switchButton.isOn = false
        switchButton.addTarget(self, action: #selector(switchUpdateValue), for: .valueChanged)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSwitch(_ sender: Any) {
        delegate.filtersCellDelegate(filterCell: self, didValueChange: switchButton.isOn)
    }
    
    func config(with name: String, isOn: Bool) {
        catogoriesLabel.text = name
        switchButton.isOn = isOn
    }
    
    func switchUpdateValue() {
        if delegate != nil {
            delegate?.filtersCellDelegate(filterCell: self, didValueChange: switchButton.isOn)
        }
    }
}
