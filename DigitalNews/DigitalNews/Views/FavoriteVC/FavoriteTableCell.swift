//
//  FavoriteTableCell.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 19/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteTableCell: UITableViewCell {

    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(news: NewsSaved) {
        
        self.newsImage.sd_setImage(with: URL(string: news.urlToImage ?? ""))
        self.labelTitulo.text = news.title
        self.labelDesc.text = news.descNews
    }
    
}
