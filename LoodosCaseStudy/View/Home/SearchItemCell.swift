//
//  SearchItemCell.swift
//  LoodosCaseStudy
//
//  Created by ismailyildirim on 21.08.2021.
//

import UIKit
import AlamofireImage

class SearchItemCell: UITableViewCell {
 
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.labelTitle.numberOfLines = 0
        self.labelYear.numberOfLines = 0
    }
    
    func initialize(model: SearchItemModel) {
        self.labelTitle.text = model.Title
        self.labelYear.text = model.Year
        if let url = URL(string: model.Poster ?? "") {
            self.imageViewPoster.af.setImage(withURL: url)
        }else{
            self.imageViewPoster.image = nil
        } 
    }
}
