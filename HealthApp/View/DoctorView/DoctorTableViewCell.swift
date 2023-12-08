//
//  DoctorTableViewCell.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var khoaLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = GetFont.nunitoBold(15)
        khoaLabel.font = GetFont.nunitoRegular(13)
    }
    func configWithData(_ data: Doctor) {
        nameLabel.text = data.full_name
        khoaLabel.text = data.majors_name
        khoaLabel.textColor = UIColor(red: 0.59, green: 0.61, blue: 0.67, alpha: 1)
        
        let attributedText = NSMutableAttributedString(string: String(data.ratio_star), attributes: [
            NSAttributedString.Key.font: GetFont.nunitoRegular(11)!,
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.28, green: 0.29, blue: 0.34, alpha: 1)
        ])
        let starNumber = NSAttributedString(
            string: " (\(data.number_of_stars) Đánh giá)",
            attributes: [
                NSAttributedString.Key.font: GetFont.nunitoRegular(11)!,
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.59, green: 0.61, blue: 0.67, alpha: 1)
            ]
        )
        attributedText.append(starNumber)
        
        starLabel.attributedText = attributedText
        getOnlineImage(on: data.avatar)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.cornerRadius = 12
        contentView.borderColor = UIColor(red: 0.93, green: 0.94, blue: 0.96, alpha: 1)
        contentView.borderWidth = 1

    }

    
    func getOnlineImage(on url: String) {
        avatarImageView.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "img-doctor"),
            options: [
                .transition(.fade(1)), // Hiệu ứng hiển thị khi ảnh được tải lên
                .cacheOriginalImage // Lưu ảnh gốc vào bộ nhớ cache
            ],
            completionHandler: { result in
                switch result {
                case .failure(_):
                    self.avatarImageView.image = UIImage(named: "img-doctor")
                case .success(_):
                    return
                }
            }
        )
    }
    
}
