//
//  ZPButton.swift
//  AppSaude_IOS
//
//  Created by Alan Silva on 30/05/21.
//

import UIKit

class ZPButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupButton()
    }
    
    private func setupButton(){
        backgroundColor = UIColor.init(named: "Main Onix")
        titleLabel?.font = UIFont(name: "Arial", size: 18)
        layer.cornerRadius = frame.size.height/2
        setTitleColor(.white, for: .normal)
    }
    
}
