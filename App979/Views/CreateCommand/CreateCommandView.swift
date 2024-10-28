import SwiftUI

struct CreateCommandView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @ObservedObject var viewModel: CreateCommandViewModel
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
                    screen = .players
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
            .disabled(viewModel.commands.count < 2)
            .opacity(viewModel.commands.count < 2 ? 0.5 : 1)
            .padding(EdgeInsets(top: 0, leading: 28, bottom: 25, trailing: 28))
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    private var header: some View {
        HStack(spacing: 15) {
            Button {
                viewModel.dc.commands = []
                withAnimation {
                    screen = .gameSetting
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
            Text("Create a command")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 10), GridItem(.flexible())], spacing: 10) {
                        ForEach(viewModel.commands, id: \.self) { command in
                            CommandCard(command: command) {
                                viewModel.remove(command)
                            }
                        }
                        addCommand
                            .onTapGesture {
                                withAnimation {
                                    viewModel.addCommandPressed()
                                }
                                
                        }
                            .opacity(viewModel.commands.count < 9 ? 1 : 0)
                        
                        
                }
                    .padding(.bottom, 92 + safeAreaInsets.bottom)
                    .clipShape(.rect(cornerRadius: 9))
            }
            .clipShape(.rect(cornerRadius: 9))
        }
    }
    
    private var addCommand: some View {
        ZStack {
            Image(systemName: "plus")
                .font(.system(size: 60, weight: .regular))
                .foregroundColor(.c249137137)
            Text("Command N")
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(9)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 153)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 9))
    }
}

struct CreateCommandView_Preview: PreviewProvider {
    
    @State static var screen: Screen = .createCommand
    
    static var previews: some View {
        CreateCommandView(viewModel: ViewModelFactory.shared.makeCreateCommandViewModel(), screen: $screen)
    }
}
