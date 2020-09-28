//
//  String.swift
//  tsbbt
//
//  Created by liu on 2020/6/17.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit
 
extension String {
    public subscript(bounds: CountableRange<Int>) -> String {
        let string = self[index(startIndex, offsetBy: bounds.lowerBound) ..< index(startIndex, offsetBy: bounds.upperBound)]
        return String(string)
    }
    
    public subscript(bounds: CountableClosedRange<Int>) -> String {
        let string = self[index(startIndex, offsetBy: bounds.lowerBound) ... index(startIndex, offsetBy: bounds.upperBound)]
        return String(string)
    }
    
    public subscript(index: Int) -> String {
        let character = self[self.index(startIndex, offsetBy: index)]
        return String(character)
    }

    func substring(to: Int) -> String {
        return self[0 ..< max(0, to)]
    }


    
}
