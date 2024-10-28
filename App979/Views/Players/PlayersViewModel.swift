import Foundation

final class PlayersViewModel: ObservableObject {
    
    let dc: DContr
    
    var commands: Array<Command>
    let currentCommand: Command
    
    init(dc: DContr) {
        self.dc = dc
        commands = dc.commands
        
        if commands.count > 0 { //TODO: - remove condition
            print("setupCurrentCommand")
            currentCommand = commands.removeFirst()
            dc.commands.removeFirst()
            dc.currentPlayer = currentCommand
        } else {
            currentCommand = Command(title: "www", image: "BananaSamurai", score: 0, totalScore: 0)
            dc.currentPlayer = currentCommand
        }
    }
    
    func backConfigure() {
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
