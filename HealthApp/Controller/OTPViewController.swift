//
//  OTPViewController.swift
//  HealthApp
//
//  Created by Hai Nam on 01/12/2023.
//

import UIKit

class OTPViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var introLabel: UILabel!
    @IBOutlet private var otpTextFields: [UITextField]!
    @IBOutlet private weak var resendOTPButton: CustomButton!
    @IBOutlet private weak var coordinatorButton: CustomButton!
    @IBOutlet weak var buttonConstrainBottom: NSLayoutConstraint!
    @IBOutlet weak var otpStackView: UIStackView!
    @IBOutlet weak var resendButtonConstrainToOtp: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    
    var countdownTimer: Timer?
    private var phoneNum : String?
    var firstTime = false
    var isEditingNow = 0
    var secondsRemaining = 60
    
    override func viewDidLoad() {
        if let font = GetFont.nunitoBold(18) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        navigationItem.title = "Xác minh số điện thoại"
        navigationItem.leftBarButtonItem = customBackButton()
        
        setPhoneLabel()
        
        setUpOTPTextField()
        
        setUpErrorLabel()
        
        setUpButtonFont()
        setUpButtonColor()
        
        addKeyboardMonitor()
        keyboardNotificate()
    }
    
    private func setUpErrorLabel() {
        errorLabel.font = GetFont.nunitoRegular(12)
    }
    
    private func setUpButtonColor() {
        resendOTPButton.setBorderColor(UIColor(red: 0.85, green: 0.86, blue: 0.88, alpha: 1), for: .disabled)
        resendOTPButton.setBorderColor(UIColor(named: K.Color.darkGreen), for: .normal)
        resendOTPButton.isEnabled = true
        
        coordinatorButton.setBackgroundColor(UIColor(named: K.Color.darkGreen), for: .normal)
        coordinatorButton.setBackgroundColor(UIColor(named: K.Color.lightGreen), for: .disabled)
        coordinatorButton.isEnabled = false
    }
    
    private func setUpButtonFont() {
        resendOTPButton.titleLabel?.font = GetFont.nunitoBold(14)
        coordinatorButton.titleLabel?.font = GetFont.nunitoBold(17)
        
        
        var newConfiguration = resendOTPButton.configuration
        newConfiguration?.attributedTitle?.font = GetFont.nunitoBold(14)
        resendOTPButton.configuration = newConfiguration
        
        
        let newConfiguration2 = coordinatorButton.configuration
        newConfiguration?.attributedTitle?.font = GetFont.nunitoBold(17)
        coordinatorButton.configuration = newConfiguration2
    }
    
    func configUpdateButton(_ button: UIButton) {
        var newConfiguration = button.configuration
        newConfiguration?.attributedTitle?.font = GetFont.nunitoBold(15)
        button.configuration = newConfiguration
    }
    func setPhoneNum(_ num: String) {
        self.phoneNum = num
    }
    
    func setPhoneLabel() {
        let attributedText = NSMutableAttributedString(string: "Vui lòng nhập mã gồm 6 chữ số đã được gửi đến bạn vào số điện thoại ", attributes: [NSAttributedString.Key.font: GetFont.nunitoRegular(14)!])
        let phoneNumber = NSAttributedString(string: "+84\(phoneNum!)", attributes: [NSAttributedString.Key.font: GetFont.nunitoBold(14)!])
        attributedText.append(phoneNumber)
        
        introLabel.attributedText = attributedText
    }
    
    func setUpOTPTextField() {
        otpTextFields = sortTextFieldsByTag(otpTextFields)
        
        for textField in otpTextFields {
            textField.delegate = self
            textField.layer.shadowColor = UIColor.black.cgColor
            textField.layer.shadowOpacity = 0.2
            textField.layer.shadowOffset = CGSize(width: 0, height: 4)
            textField.layer.shadowRadius = 20
        }
        
    }
    @IBAction func resendOTP(_ sender: CustomButton) {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        sender.isEnabled = false
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            DispatchQueue.main.async {
                let font = GetFont.nunitoBold(14)
                let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font!]
                let attributedTitle = NSAttributedString(string: "Gửi lại mã sau \(self.secondsRemaining)s", attributes: attributes)
                self.resendOTPButton.setAttributedTitle(attributedTitle, for: .normal)
            }
        } else {
            countdownTimer?.invalidate()
            secondsRemaining = 60
            DispatchQueue.main.async {
                self.resendOTPButton.isEnabled = true
                let font = GetFont.nunitoBold(14)
                let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font!]
                let attributedTitle = NSAttributedString(string: "Gửi lại mã", attributes: attributes)
                self.resendOTPButton.setAttributedTitle(attributedTitle, for: .normal)
            }
        }
    }
    @IBAction func coordinatorButtonTapped(_ sender: CustomButton) {
        if getOTP() == "111111" {
            let destinationVC = HomeViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        } else {
            errorLabel.isHidden = false
            resendButtonConstrainToOtp.constant = 68
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        countdownTimer?.invalidate()
    }
    
    deinit {
        countdownTimer?.invalidate()
    }
    
}

//MARK: - TextField Delegate
extension OTPViewController {
    
    func sortTextFieldsByTag(_ textFields: [UITextField]) -> [UITextField] {
        let sortedTextFields = textFields.sorted { $0.tag < $1.tag }
        return sortedTextFields
    }
    
    func getOTP() -> String {
        var res = ""
        for textField in otpTextFields {
            res += textField.text!
        }
        return res
    }
    
    func setBorder(_ index: Int) {
        for textField in otpTextFields {
            textField.layer.borderWidth = 0
        }
        if index != -1 {
            otpTextFields[index].layer.borderWidth = 2
        }
    }
    
    // Dùng đề điều hướng tới field cuối có kí tự và set cursor ở cuối field
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let currentIndex = otpTextFields.firstIndex(of: textField) else {
            return false
        }
        let index = getOTP().count - 1
        if index == -1 && Int(currentIndex) != 0{
            otpTextFields[0].becomeFirstResponder()
            return false
        }
        if index != -1 && Int(currentIndex) != index {
            // Điều hướng đến UITextField cuối cùng có kí tự
            let textField = otpTextFields[index]
            textField.becomeFirstResponder()
            return false // Ngăn chặn hiển thị bàn phím
        }
        
        let newPosition = textField.endOfDocument
        DispatchQueue.main.async {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        return true
    }
    
    // Dùng để setborder cho field đang được editting
    func textFieldDidBeginEditing(_ textField: UITextField) {
        firstTime = true
        guard let currentIndex = otpTextFields.firstIndex(of: textField) else {
            return
        }
        setBorder(Int(currentIndex))
    }
    
    // set border trong lần thêm đầu tiên
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentIndex = otpTextFields.firstIndex(of: textField) else {
            return false
        }
        if currentIndex == 0 && string.count == 1 {
            setBorder(0)
        }
        return true
    }
    
    // Điều hướng sang field kế tiếp khi thêm kí tự hoặc xoá
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count == 2 {
            let tmpChar = textField.text?.popLast()
            switchToNextTextField(after: textField, tmpString: tmpChar!)
        } else if textField.text?.count == 0 {
            switchBackTextField(before: textField)
        }
        coordinatorButton.isEnabled = getOTP().count == 6 ? true : false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setBorder(-1)
    }
    
    // Hàm để chuyển sang ô kế tiếp
    private func switchToNextTextField(after textField: UITextField, tmpString: Character) {
        guard let currentIndex = otpTextFields.firstIndex(of: textField) else {
            return
        }
        // Kiểm tra nếu không phải là ô cuối cùng
        if currentIndex < 5 {
            // Chuyển sang ô kế tiếp
            let nextTextField = otpTextFields[currentIndex + 1]
            nextTextField.text = String(tmpString)
            nextTextField.becomeFirstResponder()
        } else {
            // Đã nhập đủ 6 ô OTP, có thể ẩn bàn phím hoặc thực hiện hành động khác ở đây
            setBorder(5)
//            textField.resignFirstResponder()
        }
    }
    
    // Chuyển sang ô trước
    private func switchBackTextField(before textField: UITextField) {
        guard let currentIndex = otpTextFields.firstIndex(of: textField) else {
            return
        }
        // Kiểm tra nếu không phải là ô đầu tiên
        if currentIndex > 0 {
            // Chuyển sang ô trước
            let nextTextField = otpTextFields[currentIndex - 1]
            nextTextField.becomeFirstResponder()
        }
        if (getOTP().count == 0) {
            setBorder(-1)
        }
    }
    
}

//MARK: - Keyboard Monitor
extension OTPViewController {
    private func addKeyboardMonitor() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func keyboardNotificate() {
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardWillShow),
                    name: UIResponder.keyboardWillShowNotification,
                    object: nil
                )
        
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardWillHide),
                    name: UIResponder.keyboardWillHideNotification,
                    object: nil
                )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            isEditingNow += 1
            if isEditingNow == 1 {
                buttonConstrainBottom.constant += keyboardHeight
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if isEditingNow == 0 && firstTime == true {
                buttonConstrainBottom.constant -= keyboardHeight
            }
        }
    }
    
    
    @objc private func dismissKeyboard() {
        isEditingNow = 0
        view.endEditing(true)
    }
}


//MARK: - Back Button
extension OTPViewController {
    
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

