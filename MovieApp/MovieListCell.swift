//
//  MovieListCell.swift
//  MovieApp
//
//  Created by Third Eye InfoTech on 03/03/19.
//  Copyright © 2019 Third Eye InfoTech. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {

    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblReleasedData: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgvMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(movieInfo:MovieList)
    {
        lblTitle.text = movieInfo.title
        lblReleasedData.text = movieInfo.releaseDate
        lblDetail.text = "hey"//movieInfo.overView
        
    }
}
