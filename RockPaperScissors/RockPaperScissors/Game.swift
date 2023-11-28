//
//  Game.swift
//  RockPaperScissors
//
//  Created by mireu & kyle.
//

protocol Game {
    var turn: Turn { get }
    mutating func play()
    mutating func continueGame() -> Bool
}
