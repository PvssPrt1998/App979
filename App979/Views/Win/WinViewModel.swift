import Foundation

final class WinViewModel: ObservableObject {
    
    let dc: DContr
    var currentCommand: Command
    var commands: Array<Command>
    
    init(dc: DContr) {
        self.dc = dc
        commands = dc.commands
        commands.insert(dc.currentPlayer!, at: 0)
        commands.sort(by: {$0.score > $1.score})
        currentCommand = dc.currentPlayer!
        currentCommand = commands[0]
        
        dc.saveScore(commands)
    }
    
    func homeButtonPressed() {
        dc.answeredWords = []
        dc.gameWords = []
        dc.commands = []
        dc.complexity = .medium
        dc.roundTime = 30
        dc.takeAwayPoints = false
        dc.currentPlayer = nil
        
        for index in 0..<dc.categories.count {
            dc.categories[index].selected = false
        }
    }
}
