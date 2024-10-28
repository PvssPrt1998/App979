import Foundation

final class LeaderboardViewModel: ObservableObject {
    
    let dc: DContr
    
    var commands: Array<Command>
    
    init(dc: DContr) {
        self.dc = dc
        
        commands = dc.availableCommands.sorted(by: {$0.totalScore > $1.totalScore})
    }
}
