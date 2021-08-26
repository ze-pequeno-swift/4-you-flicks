//
//  PositionImage.swift
//  ZPMAPP
//
//  Created by Alan Silva on 26/08/21.
//

import UIKit

class SAImage: UIViewController {
    
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y:0.0, width: img.size.width, height: img.size.height))
        
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
    
    func addRightImageTo(txtField: UITextField, andImage img: UIImage){
        let rightImageView = UIImageView(frame: CGRect(x: 0.0, y:0.0, width: img.size.width, height: img.size.height))
        
        rightImageView.image = img
        txtField.rightView = rightImageView
        txtField.rightViewMode = .always
    }
}
