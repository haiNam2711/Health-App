//
//  PromoTableViewCell.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import UIKit

class PromoTableViewCell: UITableViewCell {

    @IBOutlet weak var promoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bookmark: UIButton!
    
    var bookmarkBool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWithData(_ data: Promotion) {
        titleLabel.text = data.name
        dateLabel.text = data.created_at
        titleLabel.font = GetFont.nunitoBold(13)
        dateLabel.font = GetFont.nunitoRegular(12)
        bookmarkBool = data.is_bookmark
        dateLabel.textColor = UIColor(red: 0.49, green: 0.52, blue: 0.6, alpha: 1)
        if bookmarkBool == true {
            bookmark.setImage(UIImage(named: "ic-bookmark"), for: .normal)
        } else {
            bookmark.setImage(UIImage(named: "ic-bookmarkwhite"), for: .normal)
        }
        bookmark.addTarget(self, action: #selector(toggleBookmark), for: .touchUpInside)
        getOnlineImage(on: data.picture)
    }
    
    @objc func toggleBookmark() {
        bookmarkBool.toggle()
        if bookmarkBool == true {
            bookmark.setImage(UIImage(named: "ic-bookmark"), for: .normal)
        } else {
            bookmark.setImage(UIImage(named: "ic-bookmarkwhite"), for: .normal)
        }
    }
    
    func getOnlineImage(on url: String) {
        promoImageView.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "img-placeholder"),
            options: [
                .transition(.fade(1)), // Hiệu ứng hiển thị khi ảnh được tải lên
                .cacheOriginalImage // Lưu ảnh gốc vào bộ nhớ cache
            ],
            completionHandler: { result in
                switch result {
                case .failure(_):
                    self.promoImageView.image = UIImage(named: "img-placeholder")
                case .success(_):
                    return
                }
            }
        )
    }
}
