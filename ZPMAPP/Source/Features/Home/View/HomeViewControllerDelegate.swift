//
//  HomeViewControllerDelegate.swift
//  ZPMAPP
//
//  Created by Hellen on 24/08/21.
//

import Foundation

protocol HomeViewControllerDelegate: AnyObject {
    
    func tappedCell(selectedMovie: Movie?)
}
