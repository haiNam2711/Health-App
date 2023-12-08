//
//  PromotionViewController.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import UIKit

class PromotionViewController: UIViewController {

    @IBOutlet weak var promotionTableView: UITableView!
    var promoAPI = PromoAPI()
    var promoList: [Promotion]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let font = GetFont.nunitoBold(18) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        navigationItem.title = "Danh sách khuyến mãi"
        navigationItem.leftBarButtonItem = customBackButton()
        
        promoAPI.delegate = self
        promoAPI.url = "https://gist.githubusercontent.com/CanThaiLinh/a373bfb717cb25a5fa4a1017995847eb/raw"
        promoAPI.fetchData()
        
        let nib = UINib(nibName: "PromoTableViewCell", bundle: nil)
        promotionTableView.register(nib, forCellReuseIdentifier: "promoTableCell")
        promotionTableView.sectionHeaderTopPadding = 0
        
    }

}

//MARK: - Tableview delegate datasource
extension PromotionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return promoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 12))
        
        guard let sectionCount = promoList?.count else { return footerView }
        // Thêm separatorView vào footerView
        if section != sectionCount - 1 {
            let separatorView = UIView(frame: CGRect(x: 0, y: 12, width: tableView.bounds.size.width, height: 1))
            separatorView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
            footerView.addSubview(separatorView)
        }
        
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 16
        }
        return 12
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let promoList else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "promoTableCell", for: indexPath) as! PromoTableViewCell
        cell.configWithData(promoList[indexPath.section])
        cell.bookmark.tintColor = .white
        return cell
    }
    
}

//MARK: - PromoAPI
extension PromotionViewController: PromoAPIDelegate {
    
    func fetchDataSuccessfully(data: [Promotion]) {
        promoList = data
        promotionTableView.reloadData()
    }
    
    func fetchDataFailed(error: Error) {
        print(error.localizedDescription)
    }
    
}

//MARK: - Back Button
extension PromotionViewController {
    
    @objc private func dismissSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    private func customBackButton() -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16 // Đặt góc để tạo hình tròn
        button.tintColor = UIColor(red: 0.14, green: 0.16, blue: 0.38, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.93, green: 0.94, blue: 0.96, alpha: 1).cgColor
        
        if let image = UIImage(named: "ic-back") {
            button.setImage(image, for: .normal)
        }
        
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        
        let customBarButtonItem = UIBarButtonItem(customView: button)
        return customBarButtonItem
    }
}
