//
//  OTPTextField.swift
//  HealthApp
//
//  Created by Hai Nam on 04/12/2023.
//

import UIKit

class OTPTextField: UITextField {
    // hide cursor
    override func caretRect(for position: UITextPosition) -> CGRect { .zero }
    // hide selection
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] { [] }
    // disable copy paste
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }
}
