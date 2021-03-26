//
//  Playground.swift
//  Bubble Breaker
//
//  Created by Oleg on 2/10/21.
//
import UIKit

typealias BubbleSelection = [(bubble: Pos, top: Bool, right: Bool, bottom: Bool, left: Bool)]

class PlayGround {
    private var bubbles = [[Bubble?]]() // 2 d array of bubbles
    let rows : Int // number of rows
    let columns : Int // number of columns
    let bubbleColours = [UIColor.red, UIColor.green, UIColor.yellow, UIColor.blue, UIColor.magenta] // array of bubble colours
    
    init(rows : Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        for _ in 0..<rows { // creating 2 d array of bubbles (appending bubbles)
            var row = [Bubble]()
            for _ in 0..<columns {
                row.append(Bubble(color: bubbleColours[Int.random(in: 0..<bubbleColours.count-2)]))
            }
            bubbles.append(row)
        }
    }
    
    func getBubbleAtPosition(row: Int, column: Int) -> Bubble? { // this function returnes  bubble at selected position or nil for non existing row and column coodinate
        if row < 0 || row >= rows || column < 0 || column >= columns { // if buble in incorrect range returns nil
            return nil
        } else {
            return bubbles[row][column] // if  correct returns bubble with  row and column indexes
        }
    }
    
    /// uses depth first search algorithm  for evaluation of selected bubble neighborhood returning  it as a set of coordinates
    func dFS(v: Pos,  discovered: inout Set<Pos>, neighborhood: inout Set<Pos>) { // Depth-first search
        discovered.insert(Pos(row: v.row, column: v.column)) //  markes current position as discovered
        // now we are sure that we never saw this position yet and it has the correct colour so it belongs to result
        neighborhood.insert(v)
        for nPos in neighborPos(position: v) { // this loop itarates  through all directions and checks if the next bubble has the same colour
            // check if we haven't seen this position yet
            if discovered.contains(nPos) == false {
                if let currentBubble = bubbles[v.row][v.column], let neighborBubble = bubbles[nPos.row][nPos.column] {
                    if currentBubble.color == neighborBubble.color {
                        //next step in depth first search algoritm in new position we know have the same colour as current position and we didn't saw it yet
                        dFS(v: nPos, discovered: &discovered, neighborhood: &neighborhood)
                    }
                }
            }
        }
    }
    // it returns adjacent bubbles to selected positions with existing coorinates
    func neighborPos(position: Pos)->[Pos] {
        
        return [Pos(row: position.row-1, column: position.column),
                Pos(row: position.row+1, column: position.column),
                Pos(row: position.row, column: position.column-1),
                Pos(row: position.row, column: position.column+1)]
            .filter { p in // filters all incorrect postitions
                return p.row >= 0 && p.column >= 0 && p.row < rows && p.column < columns
            }
    }
    

    func getSelectedBubbles(column: Int, row: Int)-> BubbleSelection{
        var disc = Set<Pos>()
        var neighb = Set<Pos>()
        // start DFS algorithm on selected position to find all connected bubbles
        // result is located in neighb var
        dFS(v: Pos(row: row, column: column), discovered: &disc, neighborhood: &neighb)
        // maps neighborhood coordinates to tuple of coordinate and bools which identifies if there is a connected neighbor on respective sides
        return neighb.map{p -> (bubble: Pos, top: Bool, right: Bool, bottom: Bool, left: Bool) in
            let topPosition = Pos(row: p.row-1, column: p.column)
            let rightPosition = Pos(row: p.row, column: p.column+1)
            let leftPosition =  Pos(row: p.row, column: p.column-1)
            let bottomPosition =  Pos(row: p.row+1, column: p.column)
            return (bubble: p, top: neighb.contains(topPosition) == false, right: neighb.contains(rightPosition) == false, bottom: neighb.contains(bottomPosition) == false, left: neighb.contains(leftPosition) == false)
        }
    }
    
    func deleteSelectedBubbles(selection:  BubbleSelection) {
        for s in selection {
            bubbles[s.bubble.row][s.bubble.column] = nil
        }
        // we are moving bubble one row down so the last row is the one from next to last row
        for row in 0..<(rows-1) {
            for column in 0..<columns {
                if bubbles[row+1][column] == nil {
                    // we need to go from bottom to top so we want to rewrite everything with the first bubble in selected column
                    for index in (0...row).reversed() {
                        // copyes current bubble to bubble below (it's empty space)
                        bubbles[index+1][column] = bubbles[index][column]
                    }
                    // all bubbles were moved one position down so the top must be empty
                    bubbles[0][column] = nil
                }
            }
        }
        //        for row in 0..<rows {
        //            for column in 0..<(columns-1) {
        //                if bubbles[row][column+1] == nil {
        //                    for index in 0...column {
        //                        bubbles[index][column] = bubbles[index][column+1]
        //
        //                    }
        //                    bubbles[row][0] = nil
        //                }
        //
        //            }
        //        }
        
    }
}

// hashable allows postions to be compared by values
struct Pos: Hashable {
    var row : Int
    var column: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(column)
    }
}
