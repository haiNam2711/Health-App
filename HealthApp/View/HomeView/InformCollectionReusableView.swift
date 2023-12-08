//
//  InformCollectionReusableView.swift
//  HealthApp
//
//  Created by Hai Nam on 07/12/2023.
//

import UIKit

class InformCollectionReusableView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let lb  = UILabel()
        lb.font = GetFont.nunitoBold(17)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let coordinatorButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.width = 82
        bt.height = 20
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(coordinatorButton)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 16).isActive = true
        
        coordinatorButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        coordinatorButton.rightAnchor.constraint(equalTo: rightAnchor,constant: -16).isActive = true
        
        coordinatorButton.setImage(UIImage(named: "img-allbutton"), for: .normal)
        coordinatorButton.setImage(UIImage(named: "img-allbutton"), for: .selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
