//
//  Canvas.swift
//  Bubble Breaker
//
//  Created by Oleg on 2/10/21.
//

import UIKit

class Canvas: UIView{
    let play = PlayGround(rows: 23, columns: 12)  // creating new PlayGround object
    let buble = Bubble(color: .red) // creating new bubble object with default colour
    var bubbleSelection: BubbleSelection?
    let sqareSideSize: Int
    override init(frame: CGRect){
        let elementWidth = Int(frame.width) / play.columns // width of element which will contain bubble
        let elementHeight = Int(frame.height) / play.rows // height of element which will contain bubble
        sqareSideSize = elementWidth > elementHeight ? elementHeight : elementWidth // determing size of bubble rectangle side
        super.init(frame: frame) // calling original intializer
        backgroundColor = UIColor.clear // frame background colour
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) { // this method will draw our bubbles on canvas
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {return} // checking if we can create graphic context
        for row in 0...play.rows { // In these nested for loops we will draw bubles in (24 rows 12 columns)
            for column in 0...play.columns {
               let bubbleRect = CGRect(x: column * sqareSideSize, y: row * sqareSideSize, width: sqareSideSize, height: sqareSideSize)
                if let bubble = play.getBubbleAtPosition(row: row, column: column) {
                    bubble.draw(whereTo: bubbleRect, context: context)
                
                }
            }
        }
        if let bs = bubbleSelection {
            drawSelectionLine(context: context, selection: bs)
        }
     }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // this method will call when user taps on the screen
        if let touch = touches.first { // checking if first touch exists (not nill)
            let position = touch.location(in: self) // retutns current location
            let column = Int(position.x)/sqareSideSize
            let row = Int(position.y)/sqareSideSize
            let selection = play.selectedBubles(column: column, row: row) //  send coordinates of selected bubble
            print(selection.count)
            bubbleSelection = selection
            setNeedsDisplay()
            
        }
    }
    func drawSelectionLine(context: CGContext, selection: BubbleSelection) {
        for bs in selection {
            let topLeft = CGPoint(x: bs.bubble.column * sqareSideSize, y: bs.bubble.row * sqareSideSize)
            if bs.top == true{
                let topRight = CGPoint(x: topLeft.x + CGFloat(sqareSideSize), y: topLeft.y)
                UIColor.brown.set()
                context.move(to: topLeft)
                context.addLine(to: topRight)
                context.strokePath()
            }
        }
       
    }
}
