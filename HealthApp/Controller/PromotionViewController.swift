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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let promoList else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "promoTableCell", for: indexPath) as! PromoTableViewCell
        cell.configWithData(promoList[indexPath.row])
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
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
