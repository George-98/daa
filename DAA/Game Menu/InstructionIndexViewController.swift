import SwiftUI;

struct InstructionIndexView: View {
    let gameData: MenuItem
    @Environment(\.dismiss) var dismiss
    @State private var selectedGame: GameItem? = nil
    
    let themeBlue = Color(red: 44/255, green: 62/255, blue: 95/255)

    var body: some View {
        NavigationStack {
            ZStack {
                themeBlue.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        Text("Instructions")
                            .font(.system(size: 30, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        ForEach(gameData.games, id: \.id) { game in
                            Button(action: { selectedGame = game }) {
                                Text(game.title)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(themeBlue)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark").foregroundColor(.white).bold()
                    }
                }
            }
            // 4. Opens the Paged Instructions
            .sheet(item: $selectedGame) { game in
                InstructionPageView(instructions: game.gameInstructions)
            }
        }
    }
}

// Make GameItem identifiable for the sheet
extension GameItem: Identifiable {}
