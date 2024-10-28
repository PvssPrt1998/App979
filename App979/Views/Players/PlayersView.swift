import SwiftUI

struct PlayersView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @ObservedObject var viewModel: PlayersViewModel
    @Binding var screen: Screen
    
    var body: some View {
        ZStack {
            Image("Background").resizable().ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))
                content
                    .padding(EdgeInsets(top: 19, leading: 16, bottom: 0, trailing: 16))
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Button {
                withAnimation {
                    screen = .game
                }
            } label: {
                Text("PLAY")
                    .font(.largeTitle.bold())
                    .foregroundColor(.c249137137)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.c255220220)
                    .clipShape(.rect(cornerRadius: 100))
                    .overlay(
                        RoundedRectangle(cornerRadius: 60)
                            .stroke(Color.c249137137.opacity(0.67), lineWidth: 3)
                    )
            }
            .padding(EdgeInsets(top: 0, leading: 28, bottom: 25, trailing: 28))
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    private var header: some View {
        HStack(spacing: 15) {
            Button {
                withAnimation {
                    viewModel.backConfigure()
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
    }
    
    private var content: some View {
        VStack(spacing: 15) {
            Text("The \(viewModel.currentCommand.title)\nare playing")
                .font(.title.bold())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Image(viewModel.currentCommand.image)
                .resizable()
                .frame(width: 174, height: 153)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 8) {
                    PlayerCard(player: viewModel.currentCommand, withSeparator: false)
                        .clipShape(.rect(cornerRadius: 9))
                    Rectangle()
                        .fill(Color.white.opacity(0.5))
                        .frame(height: 1)
                        .padding(EdgeInsets(top: 0, leading: 26, bottom: 8, trailing: 26))
                }
                ForEach(0..<viewModel.commands.count, id: \.self) { index in
                    PlayerCard(player: viewModel.commands[index], withSeparator: index == viewModel.commands.count - 1 ? false : true)
                        .padding(.bottom, index == viewModel.commands.count - 1 ? 92 + safeAreaInsets.bottom : 0)
                }
                .clipShape(.rect(cornerRadius: 9))
            }
            .clipShape(.rect(cornerRadius: 9))
        }
    }
}

struct PlayersView_Preview: PreviewProvider {
    
    @State static var screen: Screen = .players
    
    static var previews: some View {
        PlayersView(viewModel: ViewModelFactory.shared.makePlayersViewModel(), screen: $screen)
    }
}
