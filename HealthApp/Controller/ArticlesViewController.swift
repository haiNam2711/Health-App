//
//  ArticlesViewController.swift
//  HealthApp
//
//  Created by Hai Nam on 10/12/2023.
//

import UIKit

class ArticlesViewController: UIViewController {

    @IBOutlet weak var articlesTableView: UITableView!
    var articleAPI = ArticleAPI()
    var articleList: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesTableView.dataSource = self
        articlesTableView.delegate = self
        
        let nib = UINib(nibName: "PromoTableViewCell", bundle: nil)
        articlesTableView.register(nib, forCellReuseIdentifier: "promoTableCell")
        
        navigationItem.title = "Tin tức"
        navigationItem.leftBarButtonItem = customBackButton()
        
        articleAPI.delegate = self
        articleAPI.url = "https://gist.githubusercontent.com/CanThaiLinh/54afd6bc6efe3098f4480bf19a3739d2/raw"
        articleAPI.fetchData()
    }

}

//MARK: - tableview delegate datasource
extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 290
        } else {
            return 102
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articleList else { return UITableViewCell() }
        if indexPath.row == 0 {
            let cell = FirstArticleTableViewCell.loadFromNib()
            cell.configure(with: articleList[indexPath.row])
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            
            return cell
        } else {
            let cell = articlesTableView.dequeueReusableCell(withIdentifier: "promoTableCell", for: indexPath) as! PromoTableViewCell
            cell.configWithData(articleList[indexPath.row])
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
}

//MARK: - api delegate
extension ArticlesViewController: ArticleAPIDelegate {
    
    func fetchDataSuccessfully(data: [Article]) {
        articleList = data
        articlesTableView.reloadData()
    }
    
    func fetchDataFailed(error: Error) {
        print(error.localizedDescription)
    }
    
}
//MARK: - Back Button
extension ArticlesViewController {
    
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
