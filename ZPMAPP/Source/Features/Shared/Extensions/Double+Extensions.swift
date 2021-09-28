//
//  Double+Extensions.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 28/09/21.
//

import Foundation

extension Double {
    func round() -> String {
        return NSString(format: "%.1f%%", self) as String
    }
}
