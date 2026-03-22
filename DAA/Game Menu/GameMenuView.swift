import SwiftUI

struct GameMenuView: View {
    // Data passed from the previous menu
    let gameData: MenuItem
    
    // State to manage selection, similar to your UIKit gameIdSelected
    @State private var selectedGameId: String? = nil
    @State private var highScoreMode: Int = 0 // 0 for Games, 1 for High Scores
    @Environment(\.dismiss) var dismiss
    
    // The blue color from your previous screenshot
    let themeBlue = Color(red: 44/255, green: 62/255, blue: 95/255)
    
    var body: some View {
        ZStack {
            themeBlue.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Toolbar
                HStack {
                    Button(action: { /* Instructions action */ }) {
                        Image(systemName: "questionmark")
                            .font(.system(size: 25, weight: .bold))
                    }
                    Spacer()
                    Button(action: {
                        dismiss();
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 25, weight: .bold))
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.top, 20)
                
                Spacer().frame(height: 40)
                
                // Title and Subtitle
                VStack(spacing: 25) {
                    Text(gameData.title)
                        .font(.system(size: 42, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                    
                    Text(gameData.subtitle)
                        .font(.system(size: 18, weight: .medium, design: .monospaced))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                // Menu Buttons List
                VStack(spacing: 1) { // 1pt spacing creates the divider line look
                    ForEach(gameData.games, id: \.id) { game in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                if selectedGameId == game.id {
                                    selectedGameId = nil
                                } else {
                                    selectedGameId = game.id
                                }
                            }
                        }) {
                            HStack {
                                Text(game.title)
                                    .font(.system(size: 18, design: .monospaced))
                                    .foregroundColor(themeBlue)
                                Spacer()
                            }
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity)
                            .frame(height: 90)
                            .background(selectedGameId == game.id ? Color.gray.opacity(0.3) : Color.white)
                        }
                    }
                }
                .cornerRadius(12)
                .padding(.horizontal, 0) // Full width like screenshot
                
                // Play Now Button (Only shows if a game is selected)
                if let _ = selectedGameId {
                    Button(action: { /* Play Logic */ }) {
                        Text("Play Now!")
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                } else {
                    Spacer().frame(height: 100)
                }
            }
        }
    }
}

// MARK: - Preview Provider
struct GameMenuView_Previews: PreviewProvider {
    static var previews: some View {
        let mockGames = [
            GameItem(id: "flag", title: "Figures Letters And Groups (FLAG) Test", highscore: true, show_global_leaderboard: true, show_leaderboard_breakdown: true, show_leaderboard_screenshot: true, show_answers_dash: true, game_time_limit: 60, score_type: "integer", high_score_data_name: "h1", previous_score_data_name: "p1", storyboard_id: "s1", leaderboard_id: "l1", total_score_id: "t1", correct_answers_id: "c1", wrong_answers_id: "w1", gameInstructions: []),
            GameItem(id: "cut", title: "Cognitive Update Test (CUT)", highscore: true, show_global_leaderboard: true, show_leaderboard_breakdown: true, show_leaderboard_screenshot: true, show_answers_dash: true, game_time_limit: 60, score_type: "integer", high_score_data_name: "h2", previous_score_data_name: "p2", storyboard_id: "s2", leaderboard_id: "l2", total_score_id: "t2", correct_answers_id: "c2", wrong_answers_id: "w2", gameInstructions: []),
            GameItem(id: "clan", title: "Colours Letter And Number (CLAN) Test", highscore: true, show_global_leaderboard: true, show_leaderboard_breakdown: true, show_leaderboard_screenshot: true, show_answers_dash: true, game_time_limit: 60, score_type: "integer", high_score_data_name: "h3", previous_score_data_name: "p3", storyboard_id: "s3", leaderboard_id: "l3", total_score_id: "t3", correct_answers_id: "c3", wrong_answers_id: "w3", gameInstructions: [])
        ]
        
        let mockMenu = MenuItem(id: "multi", title: "Multitasking", subtitle: "But how well can you multi-task?", games: mockGames)
        
        GameMenuView(gameData: mockMenu)
    }
}
