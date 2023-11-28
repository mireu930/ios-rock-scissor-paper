//
//  Turn.swift
//  RockPaperScissors
//
//  Created by mireu & kyle.
//

enum Turn {
    case none
    case user
    case computer
}

extension Turn: CustomStringConvertible {
    var description: String {
        switch self {
        case .none:
            "미결정"
        case .user:
            "사용자"
        case .computer:
            "컴퓨터"
        }
    }
}
