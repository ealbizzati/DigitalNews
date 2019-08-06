//
//  NewsCell.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 06/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var sourceAndTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(article: Article) {
        let imageHolder = UIImage(named: "placeholder")
        imageHolder?.sd_resizedImage(with: self.frame.size, scaleMode: .aspectFit)
        if let url = URL(string: article.urlToImage ?? "") {
            imageArticle.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            titleLabel.text = article.title ?? ""
        }

    }
}
