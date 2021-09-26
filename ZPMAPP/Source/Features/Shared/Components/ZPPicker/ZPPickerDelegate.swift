//
//  ZPPickerDelegate.swift
//  ZPMAPP
//
//  Created by Hellen on 26/09/21.
//

import Foundation

protocol ZPPickerDelegate: AnyObject {
    
    func didSelectPicker(atRow row: Int, withKey key: String)
    
}
