import SwiftUI

struct ContentView: View {
    
    @State var showSplash = true
    @State var screen: Screen = .main
    
    var body: some View {
        if showSplash {
            Splash(showSplash: $showSplash)
        } else {
            switch screen {
            case .main:
                MainView(viewModel: ViewModelFactory.shared.makeMainViewModel(), screen: $screen)
            case .gameSetting:
                GameSettingView(viewModel: ViewModelFactory.shared.makeGameSettingViewModel(), screen: $screen)
            case .createCommand:
                CreateCommandView(viewModel: ViewModelFactory.shared.makeCreateCommandViewModel(), screen: $screen)
            case .players:
                PlayersView(viewModel: ViewModelFactory.shared.makePlayersViewModel(), screen: $screen)
            case .game:
                GameView(viewModel: ViewModelFactory.shared.makeGameViewModel(action: {screen = .roundResult}), screen: $screen)
            case .roundResult:
                RoundResultView(viewModel: ViewModelFactory.shared.makeRoundResultViewModel(), screen: $screen)
            case .win:
                WinView(viewModel: ViewModelFactory.shared.makeWinViewModel(), screen: $screen)
            case .settings:
                SettingView(viewModel: ViewModelFactory.shared.makeSettingViewModel(), screen: $screen)
            case.leaderboard: LeaderboardView(viewModel: ViewModelFactory.shared.makeLeaderboardViewModel(), screen: $screen)
            }
            
        }
    }
}

#Preview {
    ContentView()
}

enum Screen {
    case main
    case gameSetting
    case createCommand
    case players
    case game
    case roundResult
    case win
    case settings
    case leaderboard
}
