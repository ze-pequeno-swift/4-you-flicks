//
//  ZPRedButton.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 31/08/21.
//

import UIKit

class ZPRedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupButton()
    }
    
    private func setupButton(){
        backgroundColor = UIColor.init(named: "Main Red")
        titleLabel?.font = UIFont(name: "System", size: 15)
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
    }
}
