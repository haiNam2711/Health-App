//
//  SignUpViewController.swift
//  HealthApp
//
//  Created by Hai Nam on 01/12/2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var goButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goButton.titleLabel?.font = GetFont.nunitoBold(17)
        goButton.setBackgroundColor(UIColor(named: K.Color.darkGreen), for: .normal)
        goButton.setBackgroundColor(UIColor(named: K.Color.lightGreen), for: .disabled)
        goButton.isEnabled = false
        
        textfield.delegate = self
        setUpShadowPhoneView()
        
        navigationItem.leftBarButtonItem = customBackButton()
        navigationItem.rightBarButtonItem = customLanguageButton()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    func setUpShadowPhoneView() {
        phoneView.layer.cornerRadius = 28
        phoneView.layer.borderColor = UIColor(red: 0.93, green: 0.94, blue: 0.96, alpha: 1).cgColor
        phoneView.layer.borderWidth = 1
        
        // Áp dụng đổ bóng
        phoneView.layer.shadowColor = UIColor.black.cgColor
        phoneView.layer.shadowOpacity = 0.2
        phoneView.layer.shadowOffset = CGSize(width: 0, height: 4)
        phoneView.layer.shadowRadius = 20
        
    }
    @IBAction func goToOtpTapped(_ sender: Any) {
        let destinationVC = OTPViewController()
        destinationVC.setPhoneNum(textfield.text!)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

//MARK: - Set up left and right barbutton
extension SignUpViewController {
    
    @objc private func dismissSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    private func customBackButton() -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.backgroundColor = UIColor(red: 0, green: 61/255, blue: 115/255, alpha: 0.3)
        button.layer.cornerRadius = 16 // Đặt góc để tạo hình tròn
        button.tintColor = .white
        
        if let image = UIImage(named: "ic-back") {
            button.setImage(image, for: .normal)
        }
        
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        
        let customBarButtonItem = UIBarButtonItem(customView: button)
        return customBarButtonItem
    }
    
    func customLanguageButton() -> UIBarButtonItem{
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 69, height: 32)
        button.backgroundColor = UIColor(red: 0, green: 61/255, blue: 115/255, alpha: 0.3)
        button.layer.cornerRadius = 16 // Đặt góc để tạo hình tròn
        button.tintColor = .white
        
        if let image = UIImage(named: "img-language") {
            button.setImage(image, for: .normal)
        }
        
        let customBarButtonItem = UIBarButtonItem(customView: button)
        return customBarButtonItem
    }
    
}

//MARK: - Textfield delegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        var threshHold = 9
        threshHold = (text != "" && text[0] == "0") ? 10 : 9
        
        if textField.text!.count >= threshHold {
            goButton.isEnabled = true
        } else {
            goButton.isEnabled = false
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
