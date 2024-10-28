import SwiftUI

struct MainView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @ObservedObject var viewModel: MainViewModel
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
                    screen = .gameSetting
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
            .disabled(!viewModel.isAnySelected)
            .opacity(viewModel.isAnySelected ? 1 : 0.5)
            .padding(EdgeInsets(top: 0, leading: 28, bottom: 25, trailing: 28))
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    private var header: some View {
        HStack(spacing: 15) {
            Button {
                withAnimation {
                    screen = .leaderboard
                }
            } label: {
                Image(systemName: "rosette")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.bgSecond)
                    .frame(width: 35, height: 35)
                    .background(Color.white)
                    .clipShape(.circle)
            }
            Button {
                withAnimation {
                    screen = .settings
                }
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.bgSecond)
                    .frame(width: 35, height: 35)
                    .background(Color.white)
                    .clipShape(.circle)
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    private var content: some View {
        VStack(spacing: 16) {
            Text("What would you like to play today?")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 10), GridItem(.flexible())], spacing: 10) {
                        ForEach(viewModel.categories, id: \.self) { category in
                            CategoryCard(category: category, cardAmount: viewModel.cardAmountForCategory(category))
                                .onTapGesture {
                                    viewModel.selectCategory(category)
                                }
                        }
                }
                    .padding(.bottom, 92 + safeAreaInsets.bottom)
                    .clipShape(.rect(cornerRadius: 9))
            }
            .clipShape(.rect(cornerRadius: 9))
        }
    }
}

struct MainView_Preview: PreviewProvider {
    
    @State static var screen: Screen = .main
    
    static var previews: some View {
        MainView(viewModel: ViewModelFactory.shared.makeMainViewModel(), screen: $screen)
    }
    
}
