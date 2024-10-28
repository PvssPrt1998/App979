import Foundation

final class RoundResultViewModel: ObservableObject {
    
    let dc: DContr
    let answeredWords: Array<(Word, Bool)>
    let currentPlayer: Command
    
    var isLimitReached: Bool {
        if currentPlayer.score >= dc.numberOfPointsToWin {
            return true
        } else {
            return false
        }
    }
    var isWordEmpty: Bool {
        if dc.gameWords.count <= 1 { return true } else { return false }
    }
    
    init(dc: DContr) {
        self.dc = dc
        currentPlayer = dc.currentPlayer!
        answeredWords = dc.answeredWords
    }
    
    func nextRoundSetup() {
        dc.commands.append(currentPlayer)
        dc.currentPlayer = dc.commands.removeFirst()
        dc.answeredWords = []
    }
}
