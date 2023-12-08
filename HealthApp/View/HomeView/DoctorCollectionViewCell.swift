//
//  DoctorCollectionViewCell.swift
//  HealthApp
//
//  Created by Hai Nam on 07/12/2023.
//

import UIKit

class DoctorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorKhoa: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        doctorName.font = GetFont.nunitoBold(13)
        doctorKhoa.font = GetFont.nunitoRegular(12)
        doctorKhoa.textColor = UIColor(red: 0.59, green: 0.61, blue: 0.67, alpha: 1)
        
        layer.cornerRadius = 8
        layer.borderColor = UIColor(red: 0.93, green: 0.94, blue: 0.96, alpha: 1).cgColor
        layer.borderWidth = 1
    }

    func configWithData(_ data: Doctor) {
        doctorName.text = data.full_name
        doctorKhoa.text = data.majors_name
        
        let attributedText = NSMutableAttributedString(string: String(data.ratio_star), attributes: [
            NSAttributedString.Key.font: GetFont.nunitoRegular(11)!,
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.28, green: 0.29, blue: 0.34, alpha: 1)
        ])
        let starNumber = NSAttributedString(
            string: " (\(data.number_of_stars))",
            attributes: [
                NSAttributedString.Key.font: GetFont.nunitoRegular(11)!,
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.59, green: 0.61, blue: 0.67, alpha: 1)
            ]
        )
        attributedText.append(starNumber)
        
        reviewLabel.attributedText = attributedText
        getOnlineImage(on: data.avatar)
    }
    
    func getOnlineImage(on url: String) {
        doctorImage.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "img-doctor"),
            options: [
                .transition(.fade(1)), // Hiệu ứng hiển thị khi ảnh được tải lên
                .cacheOriginalImage // Lưu ảnh gốc vào bộ nhớ cache
            ],
            completionHandler: { result in
                switch result {
                case .failure(_):
                    self.doctorImage.image = UIImage(named: "img-doctor")
                case .success(_):
                    return
                }
            }
        )
    }
    
}
