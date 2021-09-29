//
//  Double+Extensions.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 28/09/21.
//

import Foundation

extension Double {
    func formateVoteAverage() -> String {
        return NSString(format: "%.0f%%", self) as String
    }
}
