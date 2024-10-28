import SwiftUI

struct CategoryCard: View {
    
    let category: Category
    let cardAmount: Int
    
    var body: some View {
        ZStack {
            Image(category.image)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 41)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)

            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(category.title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.textSecond)
                    Text("\(cardAmount) Cards")
                        .font(.caption2)
                        .foregroundColor(.textTertiary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Circle()
                            .stroke(Color.c242240248, lineWidth: 1)
                    )
                    .overlay(
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 9)
                            .foregroundColor(.white)
                            .frame(width: 28, height: 28)
                            .background(Color.c249137137)
                            .clipShape(.circle)
                            .opacity(category.selected ? 1 : 0)
                    )
            }
            .padding(9)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 153)
        .background(Color.c255222222)
        .clipShape(.rect(cornerRadius: 9))
    }
}

#Preview {
    CategoryCard(category: Category(title: "Sport", image: "Sport", selected: false, wordsId: 0), cardAmount: 20)
        .frame(width: 174)
        .padding()
        .background(Color.red)
}
