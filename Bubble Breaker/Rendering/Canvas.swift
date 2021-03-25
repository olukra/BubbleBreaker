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
    var totalScore = 0
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
            let column = Int(position.x)/sqareSideSize //
            let row = Int(position.y)/sqareSideSize
            var score = 0
            let selection = play.selectedBubles(column: column, row: row) //  send coordinates of selected bubble
            if selection.count > 1 { // if selection has more than one bubble
                if Utils.isSameSelection(s1: selection, s2: bubbleSelection) { // if selection is the same
                    play.deleteSelectedBubbles(selection: selection) // delete selected bubbles
                    score = selection.count * (selection.count - 1)
                    totalScore  += score
                    print(totalScore)
                    bubbleSelection = nil
                    self.setNeedsDisplay()
                } else {
                    bubbleSelection = selection // if not, select bubbles
                   
                }
                
            } else {
                bubbleSelection = nil 
            }
            
            setNeedsDisplay()
            
        }
    }
    func drawSelectionLine(context: CGContext, selection: BubbleSelection) { // this function will draw a selection line arround same colour bubbles
        for bs in selection { // iterate through all bubbles in selection
            // calculating all points of bubble square
            let topLeft = CGPoint(x: bs.bubble.column * sqareSideSize, y: bs.bubble.row * sqareSideSize)
            let bottomLeft = CGPoint(x: topLeft.x, y: topLeft.y + CGFloat(sqareSideSize))
            let topRight = CGPoint(x: topLeft.x + CGFloat(sqareSideSize), y: topLeft.y)
            let bottomRight = CGPoint(x: topLeft.x + CGFloat(sqareSideSize), y: topLeft.y + CGFloat(sqareSideSize))
            // if next bubble  has a different colour than draw line with given points (coordinates)
            if bs.top == true{
                drawLine(context: context, start: topLeft, end: topRight)
            }
            if bs.bottom == true{
                drawLine(context: context, start: bottomLeft, end: bottomRight)
            }
            if bs.left == true {
                drawLine(context: context, start: topLeft, end: bottomLeft)
            }
            if bs.right == true {
                drawLine(context: context, start: topRight, end: bottomRight)
            }
        }
        
    }
    func drawLine(context: CGContext, start: CGPoint, end: CGPoint) { // this function has all settings(methods) for line drawing
        UIColor.brown.set()
        context.move(to: start)
        context.addLine(to: end)
        context.strokePath()
    }
}
