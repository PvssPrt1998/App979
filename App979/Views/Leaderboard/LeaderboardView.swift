import SwiftUI

struct LeaderboardView: View {
    
    @ObservedObject var viewModel: LeaderboardViewModel
    @Binding var screen: Screen
    
    var body: some View {
        ZStack {
            Image("Background").resizable().ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))
                content
                    .padding(EdgeInsets(top: 29, leading: 16, bottom: 0, trailing: 16))
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
            Text("Leaderboard")
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)
        )
    }
    
    private var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(0..<viewModel.commands.count, id: \.self) { index in
                    CommandLeaderboardCard(index: index, command: viewModel.commands[index])
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .clipShape(.rect(cornerRadius: 20))
            .padding(EdgeInsets(top: 19, leading: 16, bottom: 8, trailing: 16))
        }
        .background(Color.bgSecond)
        .clipShape(.rect(cornerRadius: 32))
        .overlay(
            Circle()
                .fill(Color.bgMain)
                .frame(width: 8, height: 8)
                .padding(.top, 4)
            ,alignment: .top
        )
        .padding(.bottom, 8)
    }
}

struct LeaderboardView_Preview: PreviewProvider {
    
    @State static var screen: Screen = .leaderboard
    
    static var previews: some View {
        LeaderboardView(viewModel: ViewModelFactory.shared.makeLeaderboardViewModel(), screen: $screen)
    }
}
