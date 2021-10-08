//
//  Date+Extensions.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 07/10/21.
//

import Foundation


extension Date {

    func getFormattedDate(format: String) -> String {
           let date = DateFormatter()
            date.dateFormat = format
           return date.string(from: self)
       }
}
