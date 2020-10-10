//
//  WeatherTableViewCell.swift
//  weather
//
//  Created by Engin KUK on 10.10.2020.
//

import UIKit

class WeatherTableViewCell:UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
