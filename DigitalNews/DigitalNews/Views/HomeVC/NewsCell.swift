//
//  NewsCell.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 07/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    @IBOutlet weak var imageNews: UIImageView!

    @IBOutlet weak var labelSource: UILabel!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(article: Article) {
        imageNews.sd_setImage(with: URL(string: article.urlToImage ?? ""))
        labelSource.text = article.source?.name
        labelTitulo.text = article.title
        labelDescription.text = article.articleDescription
    }
    
}
