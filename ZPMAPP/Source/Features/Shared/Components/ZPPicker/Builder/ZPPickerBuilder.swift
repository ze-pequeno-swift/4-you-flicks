//
//  ZPPickerBuilder.swift
//  MAPP
//
//  Created by Hellen on 26/09/21.
//

import Foundation

class ZPPickerBuilder {
    
    private var pickerView = ZPPickerViewController()
    
    func set(pickerData: [String]) -> ZPPickerBuilder {
        pickerView.pickerData = pickerData
        return self
    }
    
    func set(delegate: ZPPickerDelegate) -> ZPPickerBuilder {
        pickerView.delegate = delegate
        return self
    }
    
    func set(title: String) -> ZPPickerBuilder {
        pickerView.pickerTitle = title
        return self
    }
    
    func set(confirmLabel: String) -> ZPPickerBuilder {
        pickerView.confirmLabel = confirmLabel
        return self
    }
    
    func set(cancelLabel: String) -> ZPPickerBuilder {
        pickerView.cancelLabel = cancelLabel
        return self
    }
    
    func set(lastSelectedIndex index: Int?) -> ZPPickerBuilder {
        pickerView.lastSelectedIndex = index
        return self
    }
    
    func build() -> ZPPickerViewController {
        return pickerView
    }
    
}
