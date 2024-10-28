import Foundation

final class SettingViewModel: ObservableObject {
    
    let dc: DContr
    
    @Published var lastWordForEveryone: Bool
    @Published var superWord: Bool
    
    init(dc: DContr) {
        self.dc = dc
        lastWordForEveryone = dc.lastWordForEveryone
        superWord = dc.superWord
    }
    
    func lastWordTrue() {
        if !lastWordForEveryone {
            lastWordForEveryone = true
            dc.lastWordForEveryone = true
        }
    }
    func lastWordFalse() {
        if lastWordForEveryone {
            lastWordForEveryone = false
            dc.lastWordForEveryone = false
        }
    }
    
    func superWordTrue() {
        if !superWord {
            superWord = true
            dc.superWord = true
        }
    }
    
    func superWordFalse() {
        if superWord {
            superWord = false
            dc.superWord = false
        }
    }
}
