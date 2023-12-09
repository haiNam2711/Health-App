//
//  FIrstArticleTableViewCell.swift
//  HealthApp
//
//  Created by Hai Nam on 10/12/2023.
//

import UIKit
import Kingfisher

class FirstArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateLabel.textColor = UIColor(red: 0.49, green: 0.52, blue: 0.6, alpha: 1)
        titleLabel.font = GetFont.nunitoBold(18)
        dateLabel.font = GetFont.nunitoRegular(12)
    }
    
    class func loadFromNib() -> FirstArticleTableViewCell {
        let nib = UINib(nibName: "FirstArticleTableViewCell", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! FirstArticleTableViewCell
    }
    
    func configure(with data: Article) {
        titleLabel.text = data.title
        dateLabel.text = data.created_at
        getOnlineImage(on: data.picture)
    }
    
    func getOnlineImage(on url: String) {
        titleImage.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "img-placeholder"),
            options: [
                .transition(.fade(1)), // Hiệu ứng hiển thị khi ảnh được tải lên
                .cacheOriginalImage // Lưu ảnh gốc vào bộ nhớ cache
            ],
            completionHandler: { result in
                switch result {
                case .failure(_):
                    self.titleImage.image = UIImage(named: "img-placeholder")
                case .success(_):
                    return
                }
            }
        )
    }
    
}
