//
//  businessCell.swift
//  Yelp
//
//  Created by luis castillo on 2/11/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class businessCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var reviewsLabel: UILabel!
    
    @IBOutlet weak var ratingsImageview: UIImageView!
   
    
    @IBOutlet weak var adressLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var business : Business! {  // letting this variable equal our Business class which contains names, adresses..
        
        didSet {
            nameLabel.text = business.name
            thumbImageView.setImageWith(business.imageURL!)
            categoryLabel.text = business.categories
            adressLabel.text = business.address
            reviewsLabel.text = "\(business.reviewCount!) Reviews"
            ratingsImageview.setImageWith(business.ratingImageURL!)
            distanceLabel.text = business.distance
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
