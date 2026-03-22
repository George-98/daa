import SwiftUI

struct GamesMenuView: View {
    
    let gameItems: [MenuItem]

    @State private var selectedItem: MenuItem? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 70/255, green: 98/255, blue: 125/255)
                    .ignoresSafeArea()
                
                

                // ... inside your body ...
                ScrollView {
                    VStack(spacing: 25) {
                        ForEach(gameItems, id: \.id) { item in
                            // 2. Use a Button instead of NavigationLink
                            Button {
                                selectedItem = item
                            } label: {
                                GameRowView(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical)
                }
                // 3. Attach the sheet to the ZStack or ScrollView (outside the loop)
                .sheet(item: $selectedItem) { item in
                    GameMenuView(gameData: item)
                }
            }
            .navigationBarTitleDisplayMode(.inline)  // optional but cleaner
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    GamesMenuView(gameItems: [
        MenuItem(id: "numeracy", title: "Numeracy", subtitle: "", games: []),
        MenuItem(id: "verbal_reasoning", title: "Verbal Reasoning", subtitle: "", games: []),
    ])
}
