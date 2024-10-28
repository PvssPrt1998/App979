import SwiftUI

struct GameSettingView: View {
    
    @ObservedObject var viewModel: GameSettingViewModel
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
                viewModel.playButtonPressed()
                withAnimation {
                    screen = .createCommand
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
        VStack(spacing: 16) {
            Text("Setting the game")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            complexity
            points
            roundTime
            awayPoints
        }
    }
    private var complexity: some View {
        VStack(spacing: 10) {
            Text("Complexity")
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 10) {
                Text("Easy")
                    .font(.headline)
                    .foregroundColor(viewModel.complexity == .easy ? .white : .black)
                    .frame(width: 84, height: 40)
                    .background(viewModel.complexity == .easy ? Color.c249137137 : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        viewModel.complexityPressed(.easy)
                    }
                Text("Medium")
                    .font(.headline)
                    .foregroundColor(viewModel.complexity == .medium ? .white : .black)
                    .frame(width: 84, height: 40)
                    .background(viewModel.complexity == .medium ? Color.c249137137 : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        viewModel.complexityPressed(.medium)
                    }
                Text("Hard")
                    .font(.headline)
                    .foregroundColor(viewModel.complexity == .hard ? .white : .black)
                    .frame(width: 84, height: 40)
                    .background(viewModel.complexity == .hard ? Color.c249137137 : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        viewModel.complexityPressed(.hard)
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    private var points: some View {
        VStack(spacing: 10) {
            Text("Number of points to win")
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 10) {
                Text("25")
                    .font(.headline)
                    .foregroundColor(viewModel.points == .points25 ? .white : .black)
                    .frame(width: 84, height: 40)
                    .background(viewModel.points == .points25 ? Color.c249137137 : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        viewModel.pointsPressed(.points25)
                    }
                Text("55")
                    .font(.headline)
                    .foregroundColor(viewModel.points == .points55 ? .white : .black)
                    .frame(width: 84, height: 40)
                    .background(viewModel.points == .points55 ? Color.c249137137 : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        viewModel.pointsPressed(.points55)
                    }
                Text("85")
                    .font(.headline)
                    .foregroundColor(viewModel.points == .points85 ? .white : .black)
                    .frame(width: 84, height: 40)
                    .background(viewModel.points == .points85 ? Color.c249137137 : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        viewModel.pointsPressed(.points85)
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    private var roundTime: some View {
        VStack(spacing: 10) {
            Text("Round time")
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 10) {
                Text("30")
                    .font(.headline)
                    .foregroundColor(viewModel.isRoundTime30 ? .white : .black)
                    .frame(width: 84, height: 40)
                    .background(viewModel.isRoundTime30 ? Color.c249137137 : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        if !viewModel.isRoundTime30 { viewModel.isRoundTime30 = true }
                    }
                Text("60")
                    .font(.headline)
                    .foregroundColor(!viewModel.isRoundTime30 ? .white : .black)
                    .frame(width: 84, height: 40)
                    .background(!viewModel.isRoundTime30 ? Color.c249137137 : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        if viewModel.isRoundTime30 { viewModel.isRoundTime30 = false }
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    private var awayPoints: some View {
        VStack(spacing: 10) {
            Text("Take away points for missing a\nword")
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 10) {
                Text("YES")
                    .font(.headline)
                    .foregroundColor(viewModel.awayPoints ? .white : .black)
                    .frame(width: 84, height: 40)
                    .background(viewModel.awayPoints ? Color.c249137137 : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        if !viewModel.awayPoints { viewModel.awayPoints = true }
                    }
                Text("NO")
                    .font(.headline)
                    .foregroundColor(!viewModel.awayPoints ? .white : .black)
                    .frame(width: 84, height: 40)
                    .background(!viewModel.awayPoints ? Color.c249137137 : Color.white)
                    .clipShape(.rect(cornerRadius: 6))
                    .onTapGesture {
                        if viewModel.awayPoints { viewModel.awayPoints = false }
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct GameSettingView_Preview: PreviewProvider {
    
    @State static var screen: Screen = .gameSetting
    
    static var previews: some View {
        GameSettingView(viewModel: ViewModelFactory.shared.makeGameSettingViewModel(), screen: $screen)
    }
    
}
