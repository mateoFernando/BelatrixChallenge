//
//  MovieCell.swift
//  BelatrixChallenge
//
//  Created by Fer on 21/10/2019.
//  Copyright © 2019 Fer. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
