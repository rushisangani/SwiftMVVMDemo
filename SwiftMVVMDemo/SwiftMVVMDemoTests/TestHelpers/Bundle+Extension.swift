//
//  Bundle+Extension.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 05/12/2023.
//

import Foundation

extension Bundle {
    
    static func jsonFilePath(forResource resource: String) -> String {
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else {
            return ""
        }
        return path
    }
}
