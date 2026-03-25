import SwiftUI

struct GameMenuView: View {
    // Data passed from the previous menu
    let gameData: MenuItem
    
    enum GameScreenState: Equatable {
        case none
        case playing
        case result(GameResult)
    }
    
    @State private var gameScreen: GameScreenState = .none
    
    // State to manage selection, similar to your UIKit gameIdSelected
    @State private var selectedGameId: GameType? = nil
    @State private var highScoreMode: Int = 0 // 0 for Games, 1 for High Scores
    
    @State private var showInstructions = false
    @State private var showNumeracy1 = false
    
    @State private var wrongAnswers: [WrongAnswer] = []
    
    @Environment(\.dismiss) var dismiss;
    
    @State private var gameResult: GameResult? = nil
    
    var body: some View {
        ZStack {
            Color.themeBlue.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Toolbar
                HStack {
                    Button(action: {
                        showInstructions = true;
                    }) {
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
                .zIndex(1)
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
                                    .foregroundColor(.themeBlue)
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
                    Button(action: {
                        gameScreen = .playing
                    }) {
                        Text("Play Now!")
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                } else {
                    Spacer().frame(height: 100)
                }
            }
        }
        .sheet(isPresented: $showInstructions) {
            InstructionIndexView(gameData: gameData)
        }
        .fullScreenCover(isPresented: Binding<Bool>(
            get: { gameScreen != .none },
            set: { if !$0 { gameScreen = .none } }
        )) {
            
            switch gameScreen {
                
            case .playing:
                if let game = selectedGameId {
                    switch game {
                    case .numeracy1:
                        MathsTestView { result, wrongs in
                            self.wrongAnswers = wrongs
                            self.gameResult = result
                            gameScreen = .result(result)
                        }
                        
                    case .verbalReasoning1:
                        VRTestView { result, wrongs in
                            self.wrongAnswers = wrongs
                            self.gameResult = result
                            gameScreen = .result(result)
                        }
                    }
                }
                
            case .result(let result):
                ResultView(
                    totalScore: result.score,
                    correctAnswers: result.correct,
                    wrongAnswers: result.wrong,
                    wrongAnswersArray: wrongAnswers,
                    onExitToMenu: {
                        gameScreen = .none
                    },
                    onPlayAgain: {
                        gameScreen = .playing
                    }
                )
                
            case .none:
                EmptyView()
            }
        }
    }
    
    // MARK: - Preview Provider
    struct GameMenuView_Previews: PreviewProvider {
        static var previews: some View {
            let mockGames = [
                GameItem(id: .numeracy1, title: "Figures Letters And Groups (FLAG) Test", show_leaderboard_breakdown: true, show_leaderboard_screenshot: true, game_time_limit: 60, total_score_id: "t1", correct_answers_id: "c1", wrong_answers_id: "w1", gameInstructions: []),
                GameItem(id: .numeracy1, title: "Cognitive Update Test (CUT)", show_leaderboard_breakdown: true, show_leaderboard_screenshot: true, game_time_limit: 60, total_score_id: "t2", correct_answers_id: "c2", wrong_answers_id: "w2", gameInstructions: []),
                GameItem(id: .numeracy1, title: "Colours Letter And Number (CLAN) Test", show_leaderboard_breakdown: true, show_leaderboard_screenshot: true, game_time_limit: 60,total_score_id: "t3", correct_answers_id: "c3", wrong_answers_id: "w3", gameInstructions: [])
            ]
            
            let mockMenu = MenuItem(id: "multi", title: "Multitasking", subtitle: "But how well can you multi-task?", games: mockGames)
            
            GameMenuView(gameData: mockMenu)
        }
    }
}
