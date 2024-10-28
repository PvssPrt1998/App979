import SwiftUI

struct CommandLeaderboardCard: View {
    
    let index: Int
    let command: Command
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Text("\(index)")
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.c133132148)
            }
            .frame(width: 25, height: 25)
            .overlay(Circle().stroke(Color.c230230230, lineWidth: 1.5))
            
            Image(command.image)
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipped()
                .clipShape(.circle)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(command.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(command.totalScore) points")
                    .font(.caption)
                    .foregroundColor(.c133132148)
            }
            .frame(width: 100)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if index == 0 {
                Image("Gold")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            } else if index == 1 {
                Image("Silver")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            } else if index == 2 {
                Image("Bronze")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    CommandLeaderboardCard(index: 0, command: Command(title: "Cheese Ninjas", image: "CheeseNinjas", score: 0, totalScore: 0))
        .padding()
        .background(Color.bgMain)
}
