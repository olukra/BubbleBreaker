//
//  Bubble.swift
//  Bubble Breaker
//
//  Created by Oleg on 2/10/21.
//

import UIKit

class Bubble {
    let color: UIColor
    init(color: UIColor) {
        self.color = color
    }
    func draw(whereTo: CGRect, context: CGContext) {
        let width = Float(whereTo.width)
        let height = Float(whereTo.height)
        let radius = width < height ? width / 2 : height / 2
        let center = CGPoint(x: whereTo.origin.x + CGFloat(radius), y: whereTo.origin.y + CGFloat(radius))
        color.set()
        context.addArc(center: center, radius: CGFloat(radius), startAngle: 0, endAngle: .pi * 2, clockwise: true)
        context.fillPath()
        
    }
}
