//
//  Utils.swift
//  Bubble Breaker
//
//  Created by Oleg on 3/20/21.
//

import Foundation
class Utils {
    static func isSameSelection(s1: BubbleSelection?, s2: BubbleSelection?) -> Bool { // static function which is check if
        if s1 == nil || s2 == nil {                                                    // 
            return false
        }
        let coord1 = Set(s1!.map{$0.bubble})
        let coord2 = Set(s2!.map{$0.bubble})
        return coord1 == coord2
    }
}
