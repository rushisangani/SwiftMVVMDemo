//
//  UIStoryboard+Extension.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 12/12/2023.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func createViewController<T: UIViewController>(_ type: T.Type) -> T {
        let storyboard = UIStoryboard(name: String(describing: type), bundle: nil)
        return storyboard.instantiateInitialViewController() as! T
    }
    
    func createViewController<T: UIViewController>(_ type: T.Type) -> T {
        instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
