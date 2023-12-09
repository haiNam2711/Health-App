//
//  HorizontalListCollectionViewCell.swift
//  HealthApp
//
//  Created by Hai Nam on 07/12/2023.
//

import UIKit


enum ListType {
    case article
    case promo
    case doctor
}
class HorizontalListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var horizontalListCollectionView: UICollectionView!
    var numberOfCell: Int?
    var type: ListType?
    var itemList: [Decodable]?
    var coordinateToDetail: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        horizontalListCollectionView.showsHorizontalScrollIndicator = false
        horizontalListCollectionView.delegate = self
        horizontalListCollectionView.dataSource = self
        
        let nibFile = UINib(nibName: "NewsPromoCell", bundle: nil)
        horizontalListCollectionView.register(nibFile, forCellWithReuseIdentifier: "newsPromoCell")
        let nibFile2 = UINib(nibName: "DoctorCollectionViewCell", bundle: nil)
        horizontalListCollectionView.register(nibFile2, forCellWithReuseIdentifier: "doctorCell")
    }

}
//MARK: - Collection Delegate FlowLayout
extension HorizontalListCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch type {
        case .article, .promo:
            return CGSize(width: 258, height: 220)
        default:
            return CGSize(width: 121, height: 185)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 16, height: 0)
    }
}

//MARK: - Collection DataSource
extension HorizontalListCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCell ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let coordinateToDetail else { return }
        if type == .article || type == .promo {
            coordinateToDetail()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .article:
            guard let tmpList = itemList as? [Article] else {
                return UICollectionViewCell()
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsPromoCell", for: indexPath) as! NewsPromoCell
            cell.configWithData(tmpList[indexPath.item])
            return cell
        case .promo:
            guard let tmpList = itemList as? [Promotion] else {
                return UICollectionViewCell()
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsPromoCell", for: indexPath) as! NewsPromoCell
            cell.configWithData(tmpList[indexPath.item])
            return cell
        default:
            guard let tmpList = itemList as? [Doctor] else {
                return UICollectionViewCell()
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doctorCell", for: indexPath) as! DoctorCollectionViewCell
            cell.configWithData(tmpList[indexPath.item])
            return cell
        }
        
    }
    
}
