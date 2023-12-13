//
//  UserViewController.swift
//  HealthApp
//
//  Created by Hai Nam on 10/12/2023.
//

import UIKit
import ProgressHUD

class UserViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var addressTextField: CustomTextField!
    @IBOutlet weak var birthDateTextField: CustomTextField!
    @IBOutlet weak var phoneTextField: CustomTextField!
    @IBOutlet weak var provinceTextField: CustomTextField!
    @IBOutlet weak var districtTextField: CustomTextField!
    @IBOutlet weak var wardTextField: CustomTextField!
    @IBOutlet weak var bloodTypeTextField: CustomTextField!
    
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet var headers: [UILabel]!
    @IBOutlet var footers: [UIView]!
    
    @IBOutlet weak var genderManButton: CustomButton!
    @IBOutlet weak var genderWomanButton: CustomButton!
    @IBOutlet weak var coordinatorButton: CustomButton!
    
    var grayOverlayView : UIView?
    
        
    var userAPI = UserAPI()
    var user: User?
    var genderMan: Bool = true {
        didSet {
            if genderMan == true {
                genderManButton.setBackgroundColor(.white, for: .normal)
                genderWomanButton.setBackgroundColor(.clear, for: .normal)
                genderManButton.tintColor = UIColor(named: K.Color.darkGreen)
                genderWomanButton.tintColor = .systemGray2
            } else {
                genderManButton.setBackgroundColor(.clear, for: .normal)
                genderWomanButton.setBackgroundColor(.white, for: .normal)
                genderWomanButton.tintColor = UIColor(named: K.Color.darkGreen)
                genderManButton.tintColor = .systemGray2
            }
        }
    }
    let userDefault = UserDefault()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Thông tin cá nhân"
        navigationItem.leftBarButtonItem = customBackButton()
        setUpGenderSwitch()
        setUpCoordinatorButton()
        setUpGrayView()
        
        ProgressHUD.animationType = .activityIndicator
        ProgressHUD.animate()
        ProgressHUD.mediaSize = 30
        
        setUpTextField()
        registerForKeyboardNotifications()
        birthDatePicker.maximumDate = Date()
        
        userAPI.delegate = self
        userAPI.url = "https://gist.githubusercontent.com/CanThaiLinh/00762adf68d2dddf0aea6396fd1b153a/raw"
        if loadUser() == false {
            userAPI.fetchData()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillLayoutSubviews() {
        grayOverlayView?.frame = scrollView.frame
    }
    @IBAction func coordinatorButtonTapped(_ sender: UIButton) {
        saveUser()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func birthDateButtonTapped(_ sender: UIButton) {
        grayOverlayView!.isHidden = false
        birthDatePicker.setValue(UIColor.systemGray6, forKey: "backgroundColor")
        birthDatePicker.layer.cornerRadius = 10
        scrollView.isUserInteractionEnabled = false
        birthDatePicker.layer.masksToBounds = true
        self.birthDatePicker.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.birthDatePicker.alpha = 1.0
        }
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let myString = formatter.string(from: sender.date)
        birthDateTextField.text = String(myString)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
}

//MARK: - UserDefault
extension UserViewController {
    func saveUser() {
        let user = User(last_name: lastNameTextField.text!, name: nameTextField.text!, birth_date: birthDateTextField.text!, sex: genderMan == true ? 1 : 0, phone: phoneTextField.text!, contact_email: emailTextField.text!, province_code: "Thành phố Hồ Chí Minh", district_code: "Quận 9", ward_code: "Phường Phú Hữu", address: addressTextField.text!, blood_name: "O+", avatar: "")
        userDefault.saveUser(user)
    }
    
    func loadUser() -> Bool{
        let user = userDefault.loadUser()
        if let user {
            lastNameTextField.text = user.last_name
            nameTextField.text = user.name
            birthDateTextField.text = user.birth_date
            genderMan = user.sex == 1 ? true : false
            phoneTextField.text = user.phone
            emailTextField.text = user.contact_email
            addressTextField.text = user.address
            provinceTextField.text = user.province_code
            districtTextField.text = user.district_code
            wardTextField.text = user.ward_code
            bloodTypeTextField.text = user.blood_name
            
            coordinatorButton.isEnabled = true
            ProgressHUD.remove()
            return true
        }
        return false
    }
}

//MARK: - Set up UI
extension UserViewController {
    
    func setUpGrayView() {
        grayOverlayView = UIView()
        grayOverlayView?.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        grayOverlayView?.isHidden = true
        view.insertSubview(grayOverlayView!, belowSubview: birthDatePicker)
    }
    func setUpTextField() {
        nameTextField.headerLabel = headers.filter {$0.tag == 0}[0]
        nameTextField.footerView = footers.filter {$0.tag == 0}[0]
        lastNameTextField.headerLabel = headers.filter {$0.tag == 1}[0]
        lastNameTextField.footerView = footers.filter {$0.tag == 1}[0]
        birthDateTextField.headerLabel = headers.filter {$0.tag == 2}[0]
        birthDateTextField.footerView = footers.filter {$0.tag == 2}[0]
        phoneTextField.headerLabel = headers.filter {$0.tag == 3}[0]
        phoneTextField.footerView = footers.filter {$0.tag == 3}[0]
        emailTextField.headerLabel = headers.filter {$0.tag == 4}[0]
        emailTextField.footerView = footers.filter {$0.tag == 4}[0]
        addressTextField.headerLabel = headers.filter {$0.tag == 8}[0]
        addressTextField.footerView = footers.filter {$0.tag == 8}[0]
    }
    func setUpGenderSwitch() {
        if let image = UIImage(named: "img-man") {
            genderManButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        if let image = UIImage(named: "img-woman") {
            genderWomanButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        genderMan = true
    }
    func setUpCoordinatorButton() {
        coordinatorButton.setBackgroundColor(UIColor(named: K.Color.darkGreen), for: .normal)
        coordinatorButton.setBackgroundColor(UIColor(named: K.Color.lightGreen), for: .disabled)
        coordinatorButton.isEnabled = false
    }
    @IBAction func manButtonTapped(_ sender: CustomButton) {
        genderMan = true
    }
    @IBAction func womanButtonTapped(_ sender: CustomButton) {
        genderMan = false
    }
    @objc func dismissKeyboard() {
        grayOverlayView?.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.birthDatePicker.alpha = 0.0
        } completion: { _ in
            self.birthDatePicker.isHidden = true
        }
        scrollView.isUserInteractionEnabled = true
        view.endEditing(true)
    }
    
}
//MARK: - keyboard handle
extension UserViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func onKeyboardAppear(_ notification: NSNotification) {
        let info = notification.userInfo!
        let rect: CGRect = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let kbSize = rect.size

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = insets

        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your application might not need or want this behavior.
        var aRect = self.view.frame;
        aRect.size.height -= kbSize.height;

        let activeField: CustomTextField? = [nameTextField, lastNameTextField, phoneTextField, emailTextField, addressTextField].first { $0.isFirstResponder }
        if let activeField = activeField {
            if !aRect.contains(activeField.frame.origin) {
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y-kbSize.height)
                scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }

    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
}

//MARK: - textfield delegate
extension UserViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let customTextField = textField as? CustomTextField else {
            return
        }
        customTextField.headerLabel?.textColor = UIColor(named: K.Color.darkGreen)
        customTextField.footerView?.backgroundColor = UIColor(named: K.Color.darkGreen)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let customTextField = textField as? CustomTextField else {
            return
        }
        customTextField.headerLabel?.textColor = UIColor(red: 0.59, green: 0.61, blue: 0.67, alpha: 1)
        customTextField.footerView?.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if coordinatorButton.isEnabled == true {
            if textField.tag < 3 && textField.text?.count == 0 {
                coordinatorButton.isEnabled = false
            }
        } else {
            coordinatorButton.isEnabled = checkTextFieldAllFilled()
        }
    }
    
    func checkTextFieldAllFilled() -> Bool {
        if nameTextField.text?.count == 0 || lastNameTextField.text?.count == 0 || birthDateTextField.text?.count == 0{
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

//MARK: - API delegate
extension UserViewController: UserAPIDelegate {
    func fetchDataSuccessfully(data: User) {
        ProgressHUD.remove()
        user = data
        nameTextField.text = user?.name
        lastNameTextField.text = user?.last_name
        emailTextField.text = user?.contact_email
        addressTextField.text = user?.address
        phoneTextField.text = user?.phone
        birthDateTextField.text = user?.birth_date
        bloodTypeTextField.text = user?.blood_name
        provinceTextField.text = "Thành phố Hồ Chí Minh"
        districtTextField.text = "Quận 9"
        wardTextField.text = "Phường Phú Hữu"
        
        coordinatorButton.isEnabled = true
    }
    
    func fetchDataFailed(error: Error) {
        print(error.localizedDescription)
    }
    
    
}



//MARK: - Back Button
extension UserViewController {
    
    @objc private func dismissSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    private func customBackButton() -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
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
