import SwiftUI
import StoreKit


struct SettingView: View {
    
    @Environment(\.openURL) var openURL
    @ObservedObject var viewModel: SettingViewModel
    @Binding var screen: Screen
    
    var body: some View {
        ZStack {
            Image("Background").resizable().ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))
                content
                    .padding(EdgeInsets(top: 31, leading: 16, bottom: 18, trailing: 16))
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var header: some View {
        HStack(spacing: 15) {
            Button {
                withAnimation {
                    screen = .main
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.white)
                    .frame(width: 35, height: 35)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
                    .clipShape(.circle)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            Text("Settings")
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)
        )
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            Circle()
                .fill(Color.bgMain)
                .frame(width: 8, height: 8)
                .padding(.top, 4)
            VStack(spacing: 16) {
                lastWord
                superWord
            }
            .padding(EdgeInsets(top: 28, leading: 25, bottom: 0, trailing: 25))
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.bgSecond)
        .clipShape(.rect(cornerRadius: 32))
        .overlay(buttons, alignment: .bottom)
    }
    
    private var lastWord: some View {
        VStack(spacing: 10) {
            Text("Last word for everyone")
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 10) {
                Text("YES")
                    .font(.headline)
                    .foregroundColor(viewModel.lastWordForEveryone ? .white : .textSecond)
                    .frame(width: 84, height: 40)
                    .background(viewModel.lastWordForEveryone ? Color.white.opacity(0.5) : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        viewModel.lastWordTrue()
                    }
                Text("NO")
                    .font(.headline)
                    .foregroundColor(!viewModel.lastWordForEveryone ? .white : .textSecond)
                    .frame(width: 84, height: 40)
                    .background(!viewModel.lastWordForEveryone ? Color.white.opacity(0.5) : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        viewModel.lastWordFalse()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var superWord: some View {
        VStack(spacing: 10) {
            Text("Super word for 5 points ")
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 10) {
                Text("YES")
                    .font(.headline)
                    .foregroundColor(viewModel.superWord ? .white : .textSecond)
                    .frame(width: 84, height: 40)
                    .background(viewModel.superWord ? Color.white.opacity(0.5) : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        viewModel.superWordTrue()
                    }
                Text("NO")
                    .font(.headline)
                    .foregroundColor(!viewModel.superWord ? .white : .textSecond)
                    .frame(width: 84, height: 40)
                    .background(!viewModel.superWord ? Color.white.opacity(0.5) : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        viewModel.superWordFalse()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var buttons: some View {
        VStack(spacing: 14) {
            Button {
                if let url = URL(string: "https://www.termsfeed.com/live/0cca054b-c5bb-491e-854c-fc91a3b07f82") {
                    openURL(url)
                }
            } label: {
                HStack {
                    Text("Usage policy")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.white)
                }
            }
            Rectangle().fill(Color.white.opacity(0.5)).frame(height: 1)
            Button {
                actionSheet()
            } label: {
                HStack {
                    Text("Share app")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.white)
                }
            }
            Rectangle().fill(Color.white.opacity(0.5)).frame(height: 1)
            Button {
                SKStoreReviewController.requestReviewInCurrentScene()
            } label: {
                HStack {
                    Text("Rate us")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 25, bottom: 50, trailing: 25))
    }
    
    func actionSheet() {
        guard let urlShare = URL(string: "https://apps.apple.com/us/app/blazingword-catch-clue-in-time/id6737406788") else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

struct SettingView_Preview: PreviewProvider {
    
    @State static var screen: Screen = .settings
    
    static var previews: some View {
        SettingView(viewModel: ViewModelFactory.shared.makeSettingViewModel(), screen: $screen)
    }
}

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
