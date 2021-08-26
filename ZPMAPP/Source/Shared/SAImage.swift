//
//  PositionImage.swift
//  ZPMAPP
//
//  Created by Alan Silva on 26/08/21.
//

import UIKit

class SAImage: UIViewController {
    
    var iconClick = false
    
    
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y:0.0, width: img.size.width, height: img.size.height))
        
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
    
    func addRightImageTo(txtField: UITextField, andImage img: UIImageView){
        
        let contentView = UIView()
        contentView.addSubview(img)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        img.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye")!.size.width, height: UIImage(systemName: "eye")!.size.height)
        
        txtField.rightView = contentView
        txtField.rightViewMode = .always
    }
}
