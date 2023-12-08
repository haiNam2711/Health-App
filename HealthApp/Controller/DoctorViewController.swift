//
//  DoctorViewController.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import UIKit

class DoctorViewController: UIViewController {

    @IBOutlet weak var doctorTableView: UITableView!
    let doctorAPI = DoctorAPI()
    var doctorList: [Doctor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let font = GetFont.nunitoBold(18) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        navigationItem.title = "Bác sĩ"
        navigationItem.leftBarButtonItem = customBackButton()
        doctorAPI.url = "https://gist.githubusercontent.com/CanThaiLinh/c166341bf5c5a1f9f417656598013bc9/raw"
        doctorAPI.delegate = self
        doctorAPI.fetchData()
        
        let nib = UINib(nibName: "DoctorTableViewCell", bundle: nil)
        doctorTableView.register(nib, forCellReuseIdentifier: "doctorTableCell")
        doctorTableView.showsVerticalScrollIndicator = false
    }

}

//MARK: - Tableview datasource, delegate
extension DoctorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (doctorList != nil) ? 1 : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return doctorList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let doctorList else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorTableCell", for: indexPath) as! DoctorTableViewCell
        cell.configWithData(doctorList[indexPath.section])
        return cell
    }
    
    
}

//MARK: - APIDelegate
extension DoctorViewController: DoctorAPIDelegate {
    
    func fetchDataSuccessfully(data: [Doctor]) {
        doctorList = data
        print(doctorList?.count)
        doctorTableView.reloadData()
    }
    
    func fetchDataFailed(error: Error) {
        print(error.localizedDescription)
    }
    
}

//MARK: - Back Button
extension DoctorViewController {
    
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
