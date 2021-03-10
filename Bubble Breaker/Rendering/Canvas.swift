//
//  Canvas.swift
//  Bubble Breaker
//
//  Created by Oleg on 2/10/21.
//

import UIKit
class Canvas: UIView{
    let play = PlayGround(rows: 24, columns: 12)
    let buble = Bubble(color: .red)
    let sqareSideSize: Int
    override init(frame: CGRect){
        let elementWidth = Int(frame.width) / play.columns
        let elementHeight = Int(frame.height) / play.rows
        sqareSideSize = elementWidth > elementHeight ? elementHeight : elementWidth
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        for row in 0...play.rows {
            for column in 0...play.columns {
               let bubbleRect = CGRect(x: column * sqareSideSize, y: row * sqareSideSize, width: sqareSideSize, height: sqareSideSize)
                if let bubble = play.getBubbleAtPosition(row: row, column: column) {
                    bubble.draw(whereTo: bubbleRect, context: context)
                
                }
            }
        }
     }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            let column = Int(position.x)/sqareSideSize
            let row = Int(position.y)/sqareSideSize
            play.selectedBubles(column: column, row: row)
           
        }
    }
}
