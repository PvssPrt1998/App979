import Foundation
import SwiftUI

final class ViewModelFactory {
    
    let dContr: DContr = DContr()
    
    static let shared = ViewModelFactory()
    
    private init() {}
    
    func makeMainViewModel() -> MainViewModel {
        MainViewModel(dc: dContr)
    }
    
    func makeGameSettingViewModel() -> GameSettingViewModel {
        GameSettingViewModel(dc: dContr)
    }
    
    func makeCreateCommandViewModel() -> CreateCommandViewModel {
        CreateCommandViewModel(dc: dContr)
    }
    
    func makePlayersViewModel() -> PlayersViewModel {
        PlayersViewModel(dc: dContr)
    }
    
    func makeGameViewModel(action: @escaping () -> Void) -> GameViewModel {
        GameViewModel(dc: dContr, action: action)
    }
    
    func makeRoundResultViewModel() -> RoundResultViewModel {
        RoundResultViewModel(dc: dContr)
    }
    
    func makeWinViewModel() -> WinViewModel {
        WinViewModel(dc: dContr)
    }
    
    func makeSettingViewModel() -> SettingViewModel {
        SettingViewModel(dc: dContr)
    }
    func makeLeaderboardViewModel() -> LeaderboardViewModel {
        LeaderboardViewModel(dc: dContr)
    }
}
