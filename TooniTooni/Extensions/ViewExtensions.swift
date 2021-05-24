//
//  ViewExtensions.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/05/24.
//

import UIKit

extension UIView {
    
    static var reuseIdentifier: String {
        let nameSpace = NSStringFromClass(self)
        
        guard let className = nameSpace.components(separatedBy: ".").last else {
            return nameSpace
        }
        
        return className
    }
    
}
