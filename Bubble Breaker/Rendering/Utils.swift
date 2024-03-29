//
//  Utils.swift
//  Bubble Breaker
//
//  Created by Oleg on 3/20/21.
//

import Foundation

class Utils {
    
    /// compare two bubble selections and return if they are equal
    static func isSameSelection(s1: BubbleSelection?, s2: BubbleSelection?) -> Bool {
        if s1 == nil || s2 == nil {
            return false
        }
        // transforms array of coordinates to set of coordinates because they can be compared on element to element base
        let coord1 = Set(s1!.map{$0.bubble})
        let coord2 = Set(s2!.map{$0.bubble})
        return coord1 == coord2
    }
}
