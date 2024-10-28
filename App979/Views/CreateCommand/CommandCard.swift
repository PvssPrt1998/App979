import SwiftUI

struct CommandCard: View {
    
    let command: Command
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Image(command.image)
                .resizable()
            Button {
                action()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.c249137137)
                    .frame(width: 25, height: 25)
                    .background(Color.white)
                    .clipShape(.circle)
            }
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            LinearGradient(colors: [.white, .clear], startPoint: .bottom, endPoint: .top)
                .frame(height: 71)
                .frame(maxHeight: .infinity, alignment: .bottom)
            
            Text(command.title)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.textSecond)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(EdgeInsets(top: 0, leading: 7, bottom: 16, trailing: 0))
        }
        .frame(maxWidth: 174, maxHeight: 153)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 9))
    }
}

#Preview {
    CommandCard(command: Command(title: "Cheese Ninjas", image: "CheeseNinjas", score: 0, totalScore: 0)) {
        
    }
    .frame(width: 174)
    .padding()
    .background(Color.gray)
}
