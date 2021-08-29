//
//  PositionImage.swift
//  ZPMAPP
//
//  Created by Alan Silva on 26/08/21.
//

import UIKit

class SAImage: UIViewController {
    
    var iconClick = false
    
    func addLeftImageTo(txtField: UITextField, andImage imagem: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y:0.0, width: imagem.size.width, height: imagem.size.height))
        
        leftImageView.image = imagem
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
    
    func addRightImageTo(txtField: UITextField, andImage imagem: UIImageView) {
        
        let contentView = UIView()
        contentView.addSubview(imagem)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        imagem.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye")!.size.width, height: UIImage(systemName: "eye")!.size.height)
        
        txtField.rightView = contentView
        txtField.rightViewMode = .always
    }
}
