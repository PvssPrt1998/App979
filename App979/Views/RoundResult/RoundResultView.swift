import SwiftUI

struct RoundResultView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @ObservedObject var viewModel: RoundResultViewModel
    @Binding var screen: Screen
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("Round results")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Points scored: \(viewModel.currentPlayer.score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ForEach(0..<viewModel.answeredWords.count, id: \.self) { word in
                            wordCard(viewModel.answeredWords[word])
                        }
                    }
                    .padding(.bottom, 92 + safeAreaInsets.bottom)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(EdgeInsets(top: 66, leading: 16, bottom: 0, trailing: 16))
            
            Button {
                if viewModel.isWordEmpty || viewModel.isLimitReached {
                    screen = .win
                } else {
                    viewModel.nextRoundSetup()
                    screen = .players
                }
            } label: {
                Text("Continue")
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
    
    func wordCard(_ word: (Word, Bool)) -> some View {
        HStack(spacing: 16) {
            Text(word.0.word)
                .font(.headline)
                .foregroundColor(.white)
            Image(systemName: word.1 ? "checkmark" : "xmark")
                .font(.system(size: 20, weight: .black))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
