import SwiftUI;

struct ContentView: View {
    
    @State private var showTests = false
    @State private var showContact = false
    
    var body: some View {
        ZStack {
            Color(red: 70/255, green: 98/255, blue: 125/255)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer()
                
                Text("Defence Aptitude Assessment")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 20)
                
                VStack(spacing: 30) {
                    CustomButton(title: "Tests") {
                        showTests = true;
                    }
                    
                    CustomButton(title: "Contact us") {
                        showContact = true;
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 30)
        }
        .fullScreenCover(isPresented: $showTests) {
            GamesMenuView(gameItems: [
                MenuItem(
                    id: "numeracy",
                    title: "Numeracy",
                    subtitle: "How good is your mental maths?",
                    games: [
                        GameItem(
                            id: "numeracy_1_test",
                            title: "Numerical Reasoning 1",
                            highscore: true,
                            show_global_leaderboard: true,
                            show_leaderboard_breakdown: true,
                            show_leaderboard_screenshot: true,
                            show_answers_dash: false,
                            game_time_limit: 0,
                            score_type: "integer",
                            high_score_data_name: "Topscore",
                            previous_score_data_name: "Highscore",
                            storyboard_id: "standardmath",
                            leaderboard_id: "mathsBestScore",
                            total_score_id: "Highscore",
                            correct_answers_id: "arithmeticcorrectanswers",
                            wrong_answers_id: "arithmeticwronganswers",
                            gameInstructions: [
                                "ArithmetricInstruction",
                                "ArithmetricInstruction2"
                            ]
                        ),
                        GameItem(
                            id: "numeracy_2_test",
                            title: "Numerical Reasoning 2",
                            highscore: true,
                            show_global_leaderboard: true,
                            show_leaderboard_breakdown: true,
                            show_leaderboard_screenshot: true,
                            show_answers_dash: false,
                            game_time_limit: 0,
                            score_type: "integer",
                            high_score_data_name: "Topscore",
                            previous_score_data_name: "Highscore",
                            storyboard_id: "standardmath",
                            leaderboard_id: "mathsBestScore",
                            total_score_id: "Highscore",
                            correct_answers_id: "arithmeticcorrectanswers",
                            wrong_answers_id: "arithmeticwronganswers",
                            gameInstructions: [
                                "ArithmetricInstruction",
                                "ArithmetricInstruction2"
                            ]
                        )
                    ]
                )
            ])
        }
        .sheet(isPresented: $showContact) {
            ContactUsView()
        }
    }
}

#Preview {
    ContentView()
}
