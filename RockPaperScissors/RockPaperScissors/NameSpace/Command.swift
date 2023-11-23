//
//  Command.swift
//  RockPaperScissors
//
//  Created by mireu & kyle.
//

struct Command {
    let value: Int
    var isQuit: Bool {
        return value == 0
    }
    
    init?(value: String?) {
        guard let input = value, let converted = Int(input) else { return nil }
        let validInputs = [0, 1, 2, 3]
        let isValid = validInputs.contains(converted)
        
        guard isValid else { return nil }
        self.value = converted
    }
}
