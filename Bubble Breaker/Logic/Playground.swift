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
    func dFS(v: Pos,  discovered: inout Set<Pos>, neighborhood: inout Set<Pos>) {
        discovered.insert(Pos(row: v.row, column: v.column))
        neighborhood.insert(v)
        for nPos in neighborPos(position: v) {
            if discovered.contains(nPos) == false {
                if bubbles[v.row][v.column].color == bubbles[nPos.row][nPos.column].color {
                    dFS(v: nPos, discovered: &discovered, neighborhood: &neighborhood)
                }
                
            }
        }
    }
    
    func neighborPos(position: Pos)->[Pos] {
        
        return [Pos(row: position.row-1, column: position.column),
                Pos(row: position.row+1, column: position.column),
                Pos(row: position.row, column: position.column-1),
                Pos(row: position.row, column: position.column+1)]
            .filter { p in
                return p.row > 0 && p.column > 0 && p.row < rows && p.column < columns
            }
    }
    func selectedBubles(column: Int, row: Int)-> [(bubble: Pos, top: Bool, right: Bool, bottom: Bool, left: Bool)]{
        var disc = Set<Pos>()
        var neighb = Set<Pos>()
        dFS(v: Pos(row: row, column: column), discovered: &disc, neighborhood: &neighb)
        return neighb.map{p -> (bubble: Pos, top: Bool, right: Bool, bottom: Bool, left: Bool) in
            let topPosition = Pos(row: p.row-1, column: p.column)
            let rightPosition = Pos(row: p.row, column: p.column+1)
            let leftPosition =  Pos(row: p.row, column: p.column-1)
            let bottomPosition =  Pos(row: p.row+1, column: p.column)
            return (bubble: p, top: neighb.contains(topPosition) == false, right: neighb.contains(rightPosition) == false, bottom: neighb.contains(bottomPosition) == false, left: neighb.contains(leftPosition) == false)
        }
    }
    
}

struct Pos: Hashable {
    var row : Int
    var column: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(column)
    }
}
