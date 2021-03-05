//
//  Playground.swift
//  Bubble Breaker
//
//  Created by Oleg on 2/10/21.
//
import UIKit
class PlayGround {
    private var bubbles = [[Bubble]]()
    let rows : Int
    let columns : Int
    let bubbleColours = [UIColor.red, UIColor.green, UIColor.yellow, UIColor.blue, UIColor.magenta]
    init(rows : Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        for _ in 0..<rows {
            var row = [Bubble]()
            for _ in 0..<columns {
                row.append(Bubble(color: bubbleColours[Int.random(in: 0..<bubbleColours.count-2)]))
            }
            bubbles.append(row)
        }
    }

    func getBubbleAtPosition(row: Int, column: Int) -> Bubble? {
        if row < 0 || row >= rows || column < 0 || column >= columns {
            return nil
        } else {
            return bubbles[row][column]
        }
    }
    func selectedBubles(column: Int, row: Int){
        print(bubbles[row][column].color.hash)
        for buble in bubbles {
            for b in buble {
                if bubbles[row][column].color == b[].color {
                   
                    continue
                }else {
                    break
                }
        }
    }
   
}
}
