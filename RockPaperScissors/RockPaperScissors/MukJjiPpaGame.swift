//
//  MukJjiPpaGame.swift
//  RockPaperScissors
//
//  Created by mireu & kyle.
//

struct MukJjiPpaGame: Game {
    var turn: Turn
    var rockScissorPaperGame: RockScissorPaperGame
    
    init(turn: Turn, rockScissorPaperGame: RockScissorPaperGame) {
        self.turn = turn
        self.rockScissorPaperGame = rockScissorPaperGame
    }
    
    mutating func play() {
        rockScissorPaperGame.play()
        turn = rockScissorPaperGame.turn
        while true {
            guard
                continueGame()
            else {
                return
            }
        }
    }
    
    mutating func continueGame() -> Bool {
        print("\(turn) 턴 입니다.")
        print("[\(turn) 턴] 묵(1), 찌(2), 빠(3)! <종료: 0> :", terminator: " ")
        
        let userInput = readLine()
        
        guard
            let command = Command(value: userInput)
        else {
            turn = .computer
            print(ApplicationStatusMessage.error)
            return true
        }
        
        guard
            !command.isQuit
        else {
            print(ApplicationStatusMessage.quit)
            return false
        }
        
        guard
            let userChoice = MukJjiPpaChoice(rawValue: command.userChoice),
            let computerChoice = MukJjiPpaChoice.allCases.randomElement()
        else {
            return true
        }
        
        return compareChoice(user: userChoice, computer: computerChoice)
    }
    
    private mutating func compareChoice(user: MukJjiPpaChoice, computer: MukJjiPpaChoice) -> Bool {
        switch (user, computer) {
        case (.jji,.muk),(.muk,.ppa),(.ppa,.jji):
            turn = .computer
            return true
        case (.jji,.ppa),(.muk,.jji),(.ppa,.muk):
            turn = .user
            return true
        default:
            print("\(turn)의 승리!")
            return false
        }
    }
}
