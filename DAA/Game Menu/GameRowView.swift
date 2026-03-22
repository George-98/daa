import SwiftUI;

struct GameRowView: View {
    
    let item: MenuItem
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            // Background capsule
            RoundedRectangle(cornerRadius: 50)
                .fill(Color(red: 91/255, green: 171/255, blue: 247/255))
                .frame(height: 90)
                .shadow(color: .black.opacity(0.4), radius: 3, x: -1, y: 2)
            
            // Title
            Text(item.title)
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .medium))
                .padding(.leading, 110)
            
            // Circular image
            Image(item.id)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 2)
                )
                .shadow(radius: 3)
        }
        .padding(.horizontal)
    }
}
