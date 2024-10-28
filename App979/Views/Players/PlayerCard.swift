import SwiftUI

struct PlayerCard: View {
    
    let player: Command
    let withSeparator: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                Image(player.image)
                    .resizable()
                    .frame(width: 80, height: 71)
                
                Text(player.title)
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                
                Text("\(player.score)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            if withSeparator {
                Rectangle()
                    .fill(Color.white.opacity(0.5))
                    .frame(height: 1)
                    .padding(.horizontal, 26)
            }
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        PlayerCard(player:  Command(title: "Cheese Ninjas", image: "CheeseNinjas", score: 0, totalScore: 0), withSeparator: true)
        PlayerCard(player:  Command(title: "Cheese Ninjas", image: "CheeseNinjas", score: 0, totalScore: 0), withSeparator: true)
    }
    .padding()
    .background(Color.black)
}
