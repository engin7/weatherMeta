//
//  CitiesTableViewCell.swift
//  weather
//
//  Created by Engin KUK on 8.10.2020.
//

import UIKit

class CitiesTableViewCell:UITableViewCell {
    
    @IBOutlet weak var city: UILabel!
    
  override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
  
}
