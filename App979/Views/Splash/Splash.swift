import SwiftUI

struct Splash: View {
    
    @State var value: Double = 0
    @Binding var showSplash: Bool
    
    var body: some View {
        ZStack {
            Image("SplashBackground")
                .resizable()
                .ignoresSafeArea()
            indicator
                .padding(.top, UIScreen.main.bounds.height * 0.5)
        }
        .onAppear {
            ViewModelFactory.shared.dContr.load()
            stroke()
        }
    }
    
    private var indicator: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: value)
                .stroke(Color.white, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .scaleEffect(x: -1)
            Text("\(Int(value * 100))%")
                .font(.title.bold())
                .foregroundColor(.white)
        }
        .frame(width: 100, height: 100)
    }
    
    private func stroke() {
        if value < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                self.value += 0.02
                self.stroke()
            }
        } else {
            showSplash = false
        }
    }
}

struct Splash_Preview: PreviewProvider {
    
    @State static var showSplash = true
    
    static var previews: some View {
        Splash(showSplash: $showSplash)
    }
}

struct Imagecanvp {

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
