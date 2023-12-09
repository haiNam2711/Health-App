//
//  HomeViewController.swift
//  HealthApp
//
//  Created by Hai Nam on 07/12/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var informationCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    let headerTitles = ["Tin tức", "Khuyến mãi", "Giới thiệu bác sĩ"]
    let homeApiCaller = HomeAPI()
    var homeData: HomeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up api service
        homeApiCaller.url = "https://gist.githubusercontent.com/CanThaiLinh/9ae4d163772ff5c07f8207649a2c6336/raw"
        homeApiCaller.delegate = self
        homeApiCaller.fetchData()
        
        // Set font
        nameLabel.font = GetFont.nunitoBold(15)
        statusLabel.font = GetFont.nunitoRegular(12)
        
        // Set upper corner
        informationCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        informationCollectionView.layer.sublayers?.forEach { layer in
            layer.cornerRadius = informationCollectionView.layer.cornerRadius
            layer.maskedCorners = informationCollectionView.layer.maskedCorners
        }
        
        informationCollectionView.delegate = self
        informationCollectionView.dataSource = self
        let nibFile = UINib(nibName: "HorizontalListCollectionViewCell", bundle: nil)
        informationCollectionView.register(nibFile, forCellWithReuseIdentifier: K.HomeVC.CellID)
        
        informationCollectionView.register(InformCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false

    }

}

//MARK: - Collection Delegate FlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size
        if indexPath.section == 2 {
            return CGSize(width: size.width, height: 185)
        } else {
            return CGSize(width: size.width, height: 258)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = collectionView.bounds.size
        return CGSize(width: size.width, height: 50)
    }
}

//MARK: - Collection DataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.HomeVC.CellID, for: indexPath) as! HorizontalListCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.type = .article
            cell.itemList = homeData?.articleList
            cell.numberOfCell = homeData?.articleList.count
            cell.coordinateToDetail = {
                self.navigationController?.pushViewController(DetailViewController(), animated: true)
            }
        case 1:
            cell.type = .promo
            cell.itemList = homeData?.promotionList
            cell.numberOfCell = homeData?.promotionList.count
            cell.coordinateToDetail = {
                self.navigationController?.pushViewController(DetailViewController(), animated: true)
            }
        default:
            cell.type = .doctor
            cell.itemList = homeData?.doctorList
            cell.numberOfCell = homeData?.doctorList.count
        }
        cell.horizontalListCollectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! InformCollectionReusableView
            headerView.titleLabel.text = headerTitles[indexPath.section]
            headerView.coordinatorButtonTapped = {
                switch indexPath.section {
                case 0:
                    let destinationVC = ArticlesViewController()
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                case 1:
                    let destinationVC = PromotionViewController()
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                default:
                    let destinationVC = DoctorViewController()
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
            }
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
}

//MARK: - HomeAPIDelegate
extension HomeViewController: HomeApiDelegate {
    
    func fetchDataSuccessfully(data: HomeData) {
        homeData = data
        informationCollectionView.reloadData()
    }
    
    func fetchDataFailed(error: Error) {
        print(error.localizedDescription)
    }

}
