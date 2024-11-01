import SwiftUI

struct GameView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @ObservedObject var viewModel: GameViewModel
    @State var rotationValue: Double = 0
    @State var offsetX: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    @Binding var screen: Screen
    
    var body: some View {
        ZStack {
            Image("Background").resizable().ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))
                content
                    .padding(EdgeInsets(top: 19, leading: 16, bottom: safeAreaInsets.bottom + 100, trailing: 16))
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            buttons
                .padding(.bottom, 25)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    private var header: some View {
        HStack(spacing: 15) {
            Button {
                viewModel.backPrepare()
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
    }
    
    private var content: some View {
        VStack(spacing: 24) {
            timer
            ZStack {
                if let nextWord = viewModel.nextWord {
                    wordCard(nextWord, isSuperword: viewModel.superwordCounter == viewModel.superwordValue - 1)
                }
                wordCard(viewModel.currentWord, isSuperword: viewModel.superwordCounter == viewModel.superwordValue)
                    .rotationEffect(.degrees(rotationValue))
                    .offset(x: offsetX, y: offsetY)
            }
        }
    }
    
    func wordCard(_ word: Word, isSuperword: Bool = false) -> some View {
        ZStack {
            isSuperword ? Color.bgSecond : Color.white
            Image(imageTitleForCategory(word.categoryTitle))
                .resizable()
                .scaledToFit()
                .padding(24)
            Text(word.word)
                .font(.largeTitle.bold())
                .foregroundColor(isSuperword ? .white : .textSecond)
            Text(word.categoryTitle)
                .font(.headline)
                .foregroundColor(isSuperword ? .white.opacity(0.5) : .textTertiary)
                .padding(EdgeInsets(top: 25, leading: 14, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(maxHeight: 388)
        .clipShape(.rect(cornerRadius: 9))
    }
    
    private var timer: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.white.opacity(0.5), style: StrokeStyle(lineWidth: 9, lineCap: .round))
            Circle()
                .trim(from: 0, to: Double(viewModel.remainingTime) / Double(viewModel.totalTime))
                .stroke(Color.white, style: StrokeStyle(lineWidth: 9, lineCap: .round))
                .scaleEffect(x: -1)
                .rotationEffect(.degrees(90))
            Text("\(viewModel.remainingTime)")
                .font(.title.bold())
                .foregroundColor(.white)
        }
        .frame(width: 100, height: 100)
        .onReceive(viewModel.timer, perform: { _ in
            viewModel.strokeTimer()
        })
    }
    
    private var buttons: some View {
        HStack {
            Button {
                skip()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 41, weight: .black))
                    .foregroundColor(.c249137137)
                    .frame(width: 160, height: 66)
                    .background(Color.c255220220)
                    .clipShape(.rect(cornerRadius: 100))
                    .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.c249137137, lineWidth: 3))
            }
            .disabled(viewModel.buttonsDisabled)
            //.opacity(viewModel.buttonsDisabled ? 0.2 : 1)
            Button {
                rightAnswer()
            } label: {
                Image(systemName: "checkmark")
                    .font(.system(size: 41, weight: .black))
                    .foregroundColor(.white)
                    .frame(width: 160, height: 66)
                    .background(Color.cSecondary)
                    .clipShape(.rect(cornerRadius: 100))
                    .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.white.opacity(0.67), lineWidth: 3))
            }
            .disabled(viewModel.buttonsDisabled)
            //.opacity(viewModel.buttonsDisabled ? 0.4 : 1)
        }
    }
    
    func rightAnswer() {
        if viewModel.dc.lastWordForEveryone && viewModel.remainingTime == 0 {
            viewModel.rightAnswer()
            return
        }
        viewModel.buttonsDisabled = true
        withAnimation(.linear(duration: 0.2)) {
            rotationValue = 30
            offsetX = UIScreen.main.bounds.width * 1.5
            offsetY = 50
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            rotationValue = 0
            offsetX = 0
            offsetY = 0
            viewModel.rightAnswer()
            //viewModel.buttonsDisabled = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) {
            viewModel.buttonsDisabled = false
        }
    }
    
    func skip() {
        if viewModel.dc.lastWordForEveryone && viewModel.remainingTime == 0 {
            viewModel.skip()
            return
        }
        viewModel.buttonsDisabled = true
        withAnimation(.linear(duration: 0.2)) {
            rotationValue = -30
            offsetX = -UIScreen.main.bounds.width * 1.5
            offsetY = 50
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            rotationValue = 0
            offsetX = 0
            offsetY = 0
            viewModel.skip()
            //viewModel.buttonsDisabled = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) {
            viewModel.buttonsDisabled = false
        }
    }
    
    
    func imageTitleForCategory(_ cat: String) -> String {
        switch cat {
        case "Sport" : return "Sport1"
        case "Cartoons": return "Cartoons1"
        case "Animals" : return "Animals1"
        case "Harry Potter" : return "HarryPotter1"
        case "Gaming" : return "Gaming1"
        case "Celebrities" : return "Celebrities1"
        case "Food" : return "Food1"
        case "Nature" : return "Nature1"
        case "Transportation" : return "Transportation1"
        default:
            return "Sport"
        }
    }
}

struct GameView_Preview: PreviewProvider {
    
    @State static var screen: Screen = .game
    
    static var previews: some View {
        GameView(viewModel: ViewModelFactory.shared.makeGameViewModel(action: {}), screen: $screen)
    }
    
}
