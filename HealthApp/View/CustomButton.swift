import UIKit
// 1
class CustomButton: UIButton {
    // 2
    enum ButtonState {
        case normal
        case disabled
    }
    // 3
    private var disabledBackgroundColor: UIColor?
    private var defaultBackgroundColor: UIColor? {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }
    
    private var disabledBorderColor: UIColor?
    private var defaultBorderColor: UIColor? {
        didSet {
            self.layer.borderColor = defaultBorderColor?.cgColor
        }
    }
    
    // 4. change background color on isEnabled value changed
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                if let color = defaultBackgroundColor {
                    self.backgroundColor = color
                }
                if let selfBorderColor = defaultBorderColor {
                    self.layer.borderColor = selfBorderColor.cgColor
                }
            }
            else {
                if let color = disabledBackgroundColor {
                    self.backgroundColor = color
                }
                if let selfBorderColor = disabledBorderColor {
                    self.layer.borderColor = selfBorderColor.cgColor
                }
            }
        }
    }
    
    // 5. our custom functions to set color for different state
    func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
        switch state {
        case .disabled:
            disabledBackgroundColor = color
        case .normal:
            defaultBackgroundColor = color
        }
    }
    
    func setBorderColor(_ color: UIColor?, for state: ButtonState) {
        switch state {
        case .disabled:
            disabledBorderColor = color
        case .normal:
            defaultBorderColor = color
        }
    }
    
}
