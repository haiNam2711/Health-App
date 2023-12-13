//
//  NewsPromoCell.swift
//  HealthApp
//
//  Created by Hai Nam on 07/12/2023.
//

import UIKit
import Kingfisher

class NewsPromoCell: UICollectionViewCell {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.font = GetFont.nunitoBold(13)
        dateLabel.font = GetFont.nunitoRegular(13)
        dateLabel.textColor = UIColor(red: 0.59, green: 0.61, blue: 0.67, alpha: 1)
        
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 8
        layer.masksToBounds = false
        
        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func configWithData(_ data: Decodable) {
        if let data = data as? Article {
            titleLabel.text = data.title
            dateLabel.text = data.created_at
            categoryLabel.text = data.category_name
            getOnlineImage(on: data.picture)
        } else if let data = data as? Promotion{
            titleLabel.text = data.name
            dateLabel.text = data.created_at
            categoryLabel.text = data.category_name
            getOnlineImage(on: data.picture)
        }
    }
    
    func getOnlineImage(on url: String) {
        pictureView.kf.setImage(
            with: URL(string: url),
            options: [
                .transition(.fade(1)), // Hiệu ứng hiển thị khi ảnh được tải lên
                .cacheOriginalImage // Lưu ảnh gốc vào bộ nhớ cache
            ],
            completionHandler: { result in
                switch result {
                case .failure(_):
                    self.pictureView.image = UIImage(named: "img-placeholder")
                case .success(_):
                    return
                }
            }
        )
    }
    
}
