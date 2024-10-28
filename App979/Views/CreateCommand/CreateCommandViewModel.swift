import Foundation

final class CreateCommandViewModel: ObservableObject {
    
    let dc: DContr
    
    var availableCommands: Set<Command>
    @Published var commands: Array<Command> = []
    
    init(dc: DContr) {
        self.dc = dc
        
        availableCommands = dc.availableCommands
    }
    
    func addCommandPressed() {
        if commands.count < 9 {
            let command = availableCommands.removeFirst()
            commands.append(command)
        }
    }
    
    func remove(_ command: Command) {
        guard let index = commands.firstIndex(where: {$0.title == command.title}) else { return }
        commands.remove(at: index)
        availableCommands.insert(command)
    }
    
    func playButtonPressed() {
        dc.commands = commands
    }
}
