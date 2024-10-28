import Foundation

final class CDM {
    private let modelName = "Score"
    
    lazy var coreDataStack = CDSk(modelName: modelName)
    
    func saveOrEditScore(_ commands: Set<Command>) {
        do {
            let cd = try coreDataStack.managedContext.fetch(Score.fetchRequest())
            commands.forEach { command in
                var founded = false
                for i in 0..<cd.count {
                    if cd[i].title == command.title {
                        founded = true
                        cd[i].totalScore = Int32(command.totalScore)
                    }
                }
                if !founded {
                    let score = Score(context: coreDataStack.managedContext)
                    score.title = command.title
                    score.totalScore = Int32(command.totalScore)
                }
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchScore() throws -> Array<(String, Int)> {
        var array: Array<(String,Int)> = []
        let scores = try coreDataStack.managedContext.fetch(Score.fetchRequest())
        scores.forEach { score in
            array.append((score.title, Int(score.totalScore)))
        }
        return array
    }
}
