//
//  DetailViewController.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import UIKit
import WebKit
import ProgressHUD

class DetailViewController: UIViewController {

    @IBOutlet weak var paragraph: WKWebView!
    
    var link: String?
    
    var detailAPI = DetailAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProgressHUD.animationType = .activityIndicator
        ProgressHUD.animate()
        ProgressHUD.mediaSize = 30
        
        paragraph.navigationDelegate = self
        
        navigationItem.title = "Chi tiết tin tức"
        navigationItem.leftBarButtonItem = customBackButton()
        navigationItem.rightBarButtonItem = customShareButton()
        
        detailAPI.delegate = self
        detailAPI.url = "https://gist.github.com/CanThaiLinh/84b5e70b30b4544b1cc575fc41d8938e/raw"
        detailAPI.fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ProgressHUD.remove()
    }

}

//MARK: - api delegate
extension DetailViewController: DetailAPIDelegate {
    
    
    func fetchDataSuccessfully(data: PromotionDetail) {
        link = data.link
        
        // Kích thước chữ bạn muốn
        let fontSize = 50

        // Mã HTML với thiết lập kích thước chữ
        let styledHTMLString = "<html><head><style>body{font-size: \(fontSize)px;}</style></head><body>\(data.content)</body></html>"

        // Load HTML vào UIWebView
        paragraph.loadHTMLString(styledHTMLString, baseURL: nil)
    }
    
    func fetchDataFailed(error: Error) {
        print(error.localizedDescription)
    }
    
}
//MARK: - WKNavigationDelegate
extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Quá trình tải hoàn thành, ẩn ActivityIndicator
        ProgressHUD.remove()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // Quá trình tải thất bại, ẩn ActivityIndicator
        
        ProgressHUD.remove()
        
        // Xử lý lỗi nếu cần
        print("Loading failed with error: \(error.localizedDescription)")
    }
    
}

//MARK: - Back Button
extension DetailViewController {
    
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
    
    @objc private func copyLink() {
        UIPasteboard.general.string = link
    }
    
    private func customShareButton() -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16 // Đặt góc để tạo hình tròn
        button.tintColor = UIColor(red: 0.14, green: 0.16, blue: 0.38, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.93, green: 0.94, blue: 0.96, alpha: 1).cgColor
        
        if let image = UIImage(named: "ic-share") {
            button.setImage(image, for: .normal)
        }
        
        button.addTarget(self, action: #selector(copyLink), for: .touchUpInside)
        
        let customBarButtonItem = UIBarButtonItem(customView: button)
        return customBarButtonItem
    }
}
