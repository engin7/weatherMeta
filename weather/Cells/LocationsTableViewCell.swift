//
//  LocationsTableViewCell.swift
//  weather
//
//  Created by Engin KUK on 11.10.2020.
//


import UIKit

class LocationsTableViewCell:UITableViewCell {
    
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
  
}
