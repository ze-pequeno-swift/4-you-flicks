//
//  UIViewController+Extensions.swift
//  ZPMAPP
//
//  Created by Hellen on 26/08/21.
//

import UIKit

extension UIViewController {
    
    func addLeftImageTo(textField: UITextField, andImage imagem: UIImage) {
        
        let leftImageView = UIImageView(frame: CGRect(x: 5 , y: 0, width: imagem.size.width, height: imagem.size.height))
        
        leftImageView.image = imagem
        
        // created a view to add my leftImageView
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        view.addSubview(leftImageView)
        textField.leftView = view
        
        textField.leftViewMode = .always
    }
    
    func addRightImageTo(txtField: UITextField, andImage imagem: UIImageView) {
        let contentView = UIView()
        contentView.addSubview(imagem)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        imagem.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye")!.size.width, height: UIImage(systemName: "eye")!.size.height)
        
        txtField.rightView = contentView
        txtField.rightViewMode = .always
    }
    
    @objc
    func close() {
        let viewController = navigationController?.popViewController(animated: true)
        if viewController == nil {
            navigationController?.dismiss(animated: true)
        }
    }
}
