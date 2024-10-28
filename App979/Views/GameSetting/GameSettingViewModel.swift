import Foundation

final class GameSettingViewModel: ObservableObject {
    
    enum Points {
        case points25
        case points55
        case points85
    }
    
    @Published var complexity: Complexity = .medium
    @Published var points: Points = .points25
    @Published var isRoundTime30: Bool = true
    @Published var awayPoints: Bool = false
    
    let dc: DContr
    
    init(dc: DContr) {
        self.dc = dc
    }
    
    func playButtonPressed() {
        dc.complexity = complexity
        switch points {
        case .points25:
            dc.numberOfPointsToWin = 25
        case .points55:
            dc.numberOfPointsToWin = 55
        case .points85:
            dc.numberOfPointsToWin = 85
        }
        if isRoundTime30 {
            dc.roundTime = 30
        } else { dc.roundTime = 60 }
        dc.takeAwayPoints = awayPoints
    }
    
    func complexityPressed(_ complexity: Complexity) {
        if complexity == .easy && self.complexity != .easy {
            self.complexity = .easy
        } else if complexity == .medium && self.complexity != .medium {
            self.complexity = .medium
        } else if complexity == .hard && self.complexity != .hard {
            self.complexity = .hard
        }
    }
    func pointsPressed(_ points: Points) {
        if points == .points25 && self.points != .points25 {
            self.points = .points25
        } else if points == .points55 && self.points != .points55 {
            self.points = .points55
        } else if points == .points85 && self.points != .points85 {
            self.points = .points85
        }
    }
    
    func backPrepare() {
        for index in 0..<dc.categories.count {
            dc.categories[index].selected = false
        }
    }
}
